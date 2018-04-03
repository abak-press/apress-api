module Apress
  module Api
    class DelayedFireCallback
      include Interactor

      delegate :event, :params, to: :context
      def call
        services = Apress::Api::Callbacks::Config.services(event)

        ::Resque.redis.multi do
          services.each do |service|
            ::Resque.enqueue(
              ::Apress::Api::FireCallbackJob,
              service,
              event,
              params
            )
          end
        end
      end
    end
  end
end
