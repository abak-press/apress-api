module Apress
  module Api
    module Swagger
      class Schema
        include ::Swagger::Blocks

        def self.schema_name(name)
          "#{self.name}::#{name.to_s.camelize}".to_sym
        end

        def self.swagger_classes
          @swagger_classes ||= []
        end

        def self.inherited(child)
          swagger_classes << child
        end
      end
    end
  end
end
