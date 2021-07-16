# frozen_string_literal: true
module Swagger
  module V1
    module DefaultResponses
      module BadRequest
        def self.extended(base)
          base.response 400 do
            key :description, "Переданные параметры не могут быть обработаны"
            schema do
              key :'$ref', :'Swagger::V1::::Models::Apress::Api::UnprocessableError'
            end
          end
        end
      end
    end
  end
end
