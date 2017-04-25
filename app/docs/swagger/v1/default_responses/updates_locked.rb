module Swagger
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
