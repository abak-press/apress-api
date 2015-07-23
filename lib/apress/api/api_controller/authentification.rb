module Apress
  module Api
    module ApiController
      module Authentification
        extend ActiveSupport::Concern

        included do
          attr_reader :current_api_client

          before_filter :authenticate
        end

        private

        def authenticate
          auth_service = AuthService.new(request)
          if auth_service.call
            @current_api_client = auth_service.client
            return
          end

          forbidden
        end
      end
    end
  end
end
