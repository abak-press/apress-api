# frozen_string_literal: true
module Swagger
  module V1
    module DefaultResponses
      module Unprocessable
        def self.extended(base)
          base.response 422 do
            key :description, "Переданные параметры не валидны"
            schema do
              key :'$ref', :'Swagger::V1::::Models::Apress::Api::UnprocessableError'
            end
          end
        end
      end
    end
  end
end
