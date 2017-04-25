require_relative 'unprocessable_error'

module Swagger
  module V1
    module Models
      module Apress
        module Api
          # Deprecated: Please use `UnprocessableError` instead
          class UnproccesableError < ::Apress::Documentation::Swagger::Schema
            include UnprocessableError::Schema
          end
        end
      end
    end
  end
end
