# frozen_string_literal: true

module Apress
  module Api
    module ApiController
      module Responds
        extend ActiveSupport::Concern

        included do
          before_action :set_json_format
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
