module Apress
  module Api
    module ApiController
      module Responds
        extend ActiveSupport::Concern

        included do
          before_filter :set_json_format
        end

        private

        # :nocov:
        def set_json_format
          request.format = :json
        end
        # :nocov:
      end
    end
  end
end
