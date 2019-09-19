module Apress
  module Api
    module ApiController
      module Authentification
        extend ActiveSupport::Concern

        included do
          attr_reader :current_api_client

          if (Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR == 2) || Rails::VERSION::MAJOR > 4
            before_action :find_session
            before_action :authenticate
          else
            before_filter :find_session
            before_filter :authenticate
          end
        end

        private

        def find_session
          auth_service = AuthService.new(request)
          return unless auth_service.call
          @current_api_client = auth_service.client
        end

        def authenticate
          unauthorized unless @current_api_client
        end
      end
    end
  end
end
