module Swagger
  module V1
    module DefaultResponses
      module NotFound
        def self.extended(base)
          base.response 404 do
            key :description, "Запрашиваемый ресурс не найден"
            schema do
              key :'$ref', :'Swagger::V1::::Models::Apress::Api::SimpleError'
            end
          end
        end
      end
    end
  end
end
