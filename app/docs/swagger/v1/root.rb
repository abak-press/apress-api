module Swagger
  module V1
    class Root < ::Apress::Documentation::Swagger::Schema
      swagger_root do
        key :swagger, '2.0'
        info do
          key :version, '1.0.0'
          key :title, 'Apress API'
          key :description, 'Apress API'
          key :termsOfService, 'None'
          contact do
            key :name, 'Abak-Press Team'
          end
        end

        key :basePath, '/api/v1'
        key :produces, ['application/json']

        security_definition :APIAuth do
          key :type, :apiKey
          key :in, :header
          key :name, 'Authorization'
          key :description, 'Authentication by access_id token based on HMAC'
        end
      end
    end
  end
end
