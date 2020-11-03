require 'json'

module GrapeSlate
  module Generators
    class Code < Base
      def initialize(route)
        self.route = route
      end

      def generate
        array = []
        array << code_sample
        array << response_sample
        array.join("\n")
      end

      private

      attr_accessor :route

      def curl_code_sample
        <<~BASH
        ``` shell
        curl #{documentable_route_path(route)} \
          --request #{route.request_method}\
          --data '#{param_examples.to_json}' \
          #{curl_headers} \
          --verbose
        ```
        BASH
      end

      def ruby_code_sample
        <<~RUBY
        ``` ruby
        Faraday.#{route.request_method.downcase}("#{documentable_route_path(route)}", \
        params: #{param_examples},
        headers: #{headers})
        ```
        RUBY
      end

      def js_code_sample
        <<~JS
        ``` javascript
        let response = await fetch('#{documentable_route_path(route)}', {
          method: '#{route.request_method}',
          headers: #{headers.to_json},
          body: #{param_examples.to_json}
        });

        let result = await response.json();
        console.log(result.message);
        ```
        JS
      end


      def code_sample
        [
          curl_code_sample,
          ruby_code_sample,
          js_code_sample,
        ].join("\n\n\n")
      end

      def binary_data_example
        route.settings[:example_binary_data]
      end

      def param_examples
        @params_examples ||= route.params.map do |key, value|
          unless value.is_a?(String) || value[:documentation].blank?
            [key, value[:documentation][:example]]
          end
        end.compact.to_h
      end

      def curl_headers
        headers.map do |key, value|
          "--header '#{key}: #{value}'"
        end.join(" ").strip
      end

      def headers
        headers = Headers.new(route.headers)
                {
                  'Content-Type' => 'application/json',
                  'Authorization' => 'Bearer <YOUR_TOKEN>'
                }.merge(headers.route_header_examples)
      end

      def response_sample
        example_response = route.settings[:example_response]
        unless example_response.nil?
          array = []
          array << "> Example Response\n"
          array << "```json"
          array << JSON.pretty_generate(example_response.map {|k,v| [k, v[:example]] }.to_h)
          array << "```"
          array.join("\n")
        end
      end
    end
  end
end
