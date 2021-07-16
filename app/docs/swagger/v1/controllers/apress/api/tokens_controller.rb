# frozen_string_literal: true
module Swagger
  module V1
    module Controllers
      module Apress
        module Api
          class TokensController < ::Apress::Api::Swagger::Schema
            swagger_path '/clients/{access_id}/tokens' do
              operation :post do
                key :produces, ['application/json']

                key :description, 'Refreshes token for client with given access_id'
                key :operationId, 'refreshToken'
                key :tags, ['clients']

                parameter do
                  key :name, :access_id
                  key :in, :path
                  key :description, "client's access_id"
                  key :required, true
                  key :type, :string
                end

                parameter do
                  key :name, 'refresh_token'
                  key :in, :body
                  key :description, "Client's refresh token"
                  key :required, true
                  schema type: :object do
                    property :refresh_token do
                      key :type, :string
                    end
                  end
                end

                response 200 do
                  key :description, 'Success response'
                  schema type: 'object' do
                    property :client do
                      key :'$ref', :'Swagger::V1::Models::Apress::Api::Client'
                    end
                  end
                end

                response 400 do
                  key :description, 'refresh token not valid for current access_id'
                  schema do
                    key :'$ref', :'Swagger::V1::Models::Apress::Api::SimpleError'
                  end
                end

                response 403 do
                  key :description, 'refresh token is expired'
                  schema do
                    key :'$ref', :'Swagger::V1::Models::Apress::Api::SimpleError'
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
