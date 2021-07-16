# frozen_string_literal: true
module Swagger
  module V1
    module DefaultResponses
      module UpdatedLocked
        def self.extended(base)
          base.response 503 do
            key :description, "Закрыто редактирование"
          end
        end
      end
    end
  end
end
