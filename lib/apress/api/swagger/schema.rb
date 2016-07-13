module Apress
  module Api
    module Swagger
      class Schema
        include ::Swagger::Blocks

        def self.schema_name(name)
          "#{self.name}::#{name.to_s.camelize}".to_sym
        end

        def self.swagger_classes
          ObjectSpace.each_object(Class).select { |klass| klass < self }
        end
      end
    end
  end
end
