# frozen_string_literal: true
module Schema
  module Api
    module V1
      module Types
        module Apress
          module Api
            class Link < ::Apress::Api::Swagger::Schema
              swagger_schema name.to_sym do
                key :required, [:href]
                key :description, 'A representation of a link object'

                property :href do
                  key :type, :string
                  key :description, 'A string containing the link’s URL'
                  key :example, 'https://www.example.com/api/v1/review_comments'
                end

                property :meta do
                  key :type, :object
                  key :description, 'A meta object containing non-standard meta-information about the link'
                end
              end
            end
          end
        end
      end
    end
  end
end
