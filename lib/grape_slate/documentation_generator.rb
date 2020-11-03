require 'fileutils'

module GrapeSlate
  class DocumentationGenerator
    attr_accessor :filenames
    def initialize(api_class)
      self.api_class = api_class
      self.filenames = []
    end

    def run!
      ensure_partials_dir
      generate_partials!
      generate_index!
      return true
    end

    def namespaces
      api_class.routes.map(&:namespace).uniq
    end

    private

    def ensure_partials_dir
      FileUtils.mkdir_p(
        File.join(
          GrapeSlate.configuration.partials_dir, GrapeSlate.configuration.partials_dir
        )
      )
    end

    def generate_partials!
      namespaces.each do |namespace|
        document = Generators::Document.new namespace, routes_for(namespace)
        document_contents = document.generate

        filenames << document.filepath.to_s
        dirpath = Pathname.new(
          File.join(
            GrapeSlate.configuration.output_dir,
            GrapeSlate.configuration.partials_dir,
            document.dirname
          )
        )
        filepath = dirpath.join(document.filename.to_s + file_extension)

        FileUtils.mkdir_p(dirpath)

        File.open(filepath, 'w+') do |file|
          document_contents.each do |content|
            file.write content
            file.write "\n\n"
          end
        end
      end
    end

    def index_path
      File.join(GrapeSlate.configuration.output_dir, 'includes', '_resources.html.erb')
    end

    def generate_index!
      content = <<~RHTML
        <h1 id="#resources">Resources</h1>
      RHTML
      filenames.each do |filename|
        content << "<%= partial \"#{GrapeSlate.configuration.partials_dir}#{filename}\" %>\n"
      end
      File.open(index_path, 'w+') do |file|
        file.write content
      end
    end

    attr_accessor :api_class

    def routes_for(namespace)
      api_class.routes.select { |route| route.namespace == namespace }
    end

    def file_extension
      '.md'
    end
  end
end
