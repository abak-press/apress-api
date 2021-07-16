# frozen_string_literal: true
module Swagger
  module V1
    module DefaultResponses
      module Unauthenticated
        def self.extended(base)
          base.response 401 do
            key :description, "Запрос не прошел аутентификацию (проблема с подписью запроса)"
            schema do
              key :'$ref', :'Swagger::V1::::Models::Apress::Api::SimpleError'
            end
          end
        end
      end
    end
  end
end
