module Apress
  module Api
    module V1
      class CallbacksController < ApiController::Base
        include Pundit

        def create
          authorize :'apress/api/callback'

          event_params = params[:params] || {}

          Resque.redis.multi do
            Apress::Api::Callbacks::Config.handlers(
              service: params.require(:service),
              event: params.require(:event)
            ).each { |handler| Resque.enqueue(Apress::Api::EventHandlerEnqueueingJob, handler, event_params) }
          end

          head 201
        end

        private

        def pundit_user
          current_api_client
        end
      end
    end
  end
end
