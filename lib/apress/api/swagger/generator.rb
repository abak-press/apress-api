module Apress
  module Api
    module Swagger
      class Generator
        def initialize(path = nil)
          @path = path
        end

        def data
          return @data if defined?(@data)
          classes = Apress::Api::Swagger::Schema.swagger_classes
          @data = ::Swagger::Blocks.build_root_json(classes)
        end

        def generate_file
          if @path
            File.open(@path, 'w') { |file| file.write(data.to_json) }
          else
            raise 'No Docs path provided'
          end
        end
      end
    end
  end
end
