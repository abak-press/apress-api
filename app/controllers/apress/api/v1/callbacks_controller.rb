module Apress
  module Api
    module V1
      class CallbacksController < ApiController::Base
        include Pundit

        def create
          authorize :'apress/api/callback'

          job = Apress::Api::Callbacks::Config.handler(
            service: params.require(:service),
            event: params.require(:event)
          ).camelize.constantize
          event_params = params[:params] || {}

          if job.respond_to?(:enqueue)
            job.enqueue(event_params)
          else
            ::Resque.enqueue(job, event_params)
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
