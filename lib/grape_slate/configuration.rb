module GrapeSlate
  class Configuration

    # The name of the API documentation.
    # @return [String]
    attr_accessor :name

    # The description of the API documentation.
    # @return [String]
    attr_accessor :description

    # Whether to include root element in examples.
    # @return [Boolean]
    attr_accessor :include_root

    # Resources to exclude from the documentation.
    # @return [Array]
    attr_accessor :resource_exclusion

    # The output dir for the generated documentation
    # @return [String]
    attr_accessor :output_dir

    # The output dir for the generated partials
    # @return [String]
    attr_accessor :partials_dir

    # The base path of the API
    # @return [String]
    attr_accessor :base_path

    def initialize
      @name = 'BOXT API'
      @description = 'My API description'
      @include_root = false
      @resource_exclusion = []
      @output_dir = 'tmp'
      @base_path = ''
    end
  end

  # @return [GrapeSlate::Configuration] GrapeSlate's current configuration
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Set GrapeSlate's configuration
  # @param config [GrapeSlate::Configuration]
  def self.configuration=(config)
    @configuration = config
  end

  # Modify GrapeSlate's current configuration
  # @yieldparam [GrapeSlate::Configuration] config current GrapeSlate config
  # ```
  # GrapeSlate.configure do |config|
  #   config.name = 'New Name'
  # end
  # ```
  def self.configure
    yield configuration
  end
end
