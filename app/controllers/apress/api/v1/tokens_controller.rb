module Apress
  module Api
    module V1
      class TokensController < ApiController::Base
        skip_before_filter :authenticate, only: :create

        def create
          @client = Client.find_by_access_id!(params.require(:client_id))

          return bad_request if @client.refresh_token != params.require(:refresh_token)
          return forbidden if @client.refresh_token_expired?

          @client.regenerate_tokens!
        end
      end
    end
  end
end
