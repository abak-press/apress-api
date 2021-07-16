# frozen_string_literal: true
module Apress
  module Api
    module ApiController
      module Responds
        extend ActiveSupport::Concern

        included do
          if (Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR == 2) || Rails::VERSION::MAJOR > 4
            before_action :set_json_format
          else
            before_filter :set_json_format
          end
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
