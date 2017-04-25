module Swagger
  module DefaultResponses
    module Unauthorized
      def self.extended(base)
        base.response 403 do
          key :description, "Нет доступа к ресурсу"
          schema do
            key :'$ref', :'Swagger::V1::::Models::Apress::Api::SimpleError'
          end
        end
      end
    end
  end
end
