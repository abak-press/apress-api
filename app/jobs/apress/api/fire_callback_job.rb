module Apress
  module Api
    class FireCallbackJob
      include Resque::Integration
      extend Resque::Plugins::ExponentialBackoff

      queue :api_callbacks

      @retry_exceptions = {
        Apress::Api::Callbacks::FireCallbackError => [1, 60, 300, 3600],
        Apress::Api::Callbacks::RepeatCallbackError => 300
      }
      @ignore_exceptions = [Apress::Api::Callbacks::RepeatCallbackError]

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
