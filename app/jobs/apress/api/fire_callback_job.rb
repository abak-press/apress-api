module Apress
  module Api
    class FireCallbackJob
      include Resque::Integration

      queue :api_callbacks
      retrys delay: 10, limit: 2
      @retry_exceptions = [Apress::Api::Callbacks::FireCallbackError]

      def self.perform(service, event, params)
        callback_class = "#{service}_client/fire_callback".camelize.constantize

        callback_class.call!(
          event: event,
          params: params
        )
      end
    end
  end
end
