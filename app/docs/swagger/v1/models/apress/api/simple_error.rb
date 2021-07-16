# frozen_string_literal: true
module Swagger
  module V1
    module Models
      module Apress
        module Api
          class SimpleError < ::Apress::Documentation::Swagger::Schema
            swagger_schema name.to_sym do
              keys = [
                :status,
                :message,
                :backtrace
              ]

              key :required, keys

              keys.each do |k|
                property k do
                  key :type, :string
                end
              end
            end
          end
        end
      end
    end
  end
end
