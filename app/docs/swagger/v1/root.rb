# frozen_string_literal: true
module Swagger
  module V1
    class Root < ::Apress::Documentation::Swagger::Schema
      swagger_root do
        key :swagger, '2.0'
        info do
          key :version, Rails.application.config.api[:version]
          key :title, Rails.application.config.api[:title]
          key :description, Rails.application.config.api[:description]
          key :termsOfService, Rails.application.config.api[:terms_of_service]

          contact do
            key :name, Rails.application.config.api[:contact_name]
          end
        end

        key :basePath, Rails.application.config.api[:base_path]
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
