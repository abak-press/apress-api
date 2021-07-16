# frozen_string_literal: true
module Schema
  module Api
    module V1
      module Types
        module Apress
          module Api
            class Links < ::Apress::Api::Swagger::Schema
              swagger_schema name.to_sym do
                key :description, 'A representation of a links object (http://jsonapi.org/format/#document-links)'
                key :type, :object
                key :additionalProperties, {
                      oneOf: [
                        {'type': 'string'},
                        {'$ref' => '#/definitions/Schema::Api::V1::Types::Apress::Api::Link'}
                      ]
                    }
              end
            end
          end
        end
      end
    end
  end
end
