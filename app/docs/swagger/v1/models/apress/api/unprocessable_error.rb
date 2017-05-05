module Swagger
  module V1
    module Models
      module Apress
        module Api
          class UnprocessableError < ::Apress::Documentation::Swagger::Schema
            module Schema
              extend ActiveSupport::Concern

              included do
                swagger_schema name.to_sym do
                  key :required, [:errors, :status]

                  property :status do
                    key :type, :string
                  end

                  property :errors do
                    key :type, :array
                    items do
                      key :type, :object
                      property :error do
                        key :type, :object
                      end
                    end
                  end
                end
              end
            end

            include Schema
          end
        end
      end
    end
  end
end
