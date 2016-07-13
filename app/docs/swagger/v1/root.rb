module Swagger
  module V1
    class Root < ::Apress::Api::Swagger::Schema
      swagger_root do
        key :swagger, '2.0'
        info do
          key :version, '1.0.0'
          key :title, 'Apress API'
          key :description, 'Apress API'
          key :termsOfService, 'None'
          contact do
            key :name, 'Aback-Press Team'
          end
        end

        key :host, defined?(HOST) ? HOST : '/'
        key :basePath, '/api/v1'
        key :produces, ['application/json']

        security_definition :authorization do
          key :type, :apikey
          key :name, :apiKey
          key :description, 'signature for response'
          key :in, :header
        end
      end
    end
  end
end
