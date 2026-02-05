# frozen_string_literal: true

module Apress
  module Api
    module ApiController
      module Authentification
        extend ActiveSupport::Concern

        included do
          attr_reader :current_api_client

          before_action :find_session
          before_action :authenticate
        end

        private

        def find_session
          auth_service = AuthService.new(request)
          return unless auth_service.call

          @current_api_client = auth_service.client
        end

        def authenticate
          forbidden unless @current_api_client
        end
      end
    end
  end
end
