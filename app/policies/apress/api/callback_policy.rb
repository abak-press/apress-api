module Apress
  module Api
    class CallbackPolicy
      attr_reader :client

      def initialize(client, _callback)
        @client = client
      end

      def create?
        Apress::Api::Callbacks::Config.allowed_client?(client)
      end
    end
  end
end
