module Apress
  module Api
    class AuthService
      rattr_initialize :request

      attr_reader :client

      delegate :query_parameters, to: :request

      # Find Client by access_id, check sercret_key
      #
      # Returns boolean
      def call
        @client = Client.find_by_access_id(access_id)
        return false unless client

        return false if client.secret_token_expired?

        return true if not_check_signature?
        ::ApiAuth.authentic?(request, client.secret_token)
      end

      private

      def access_id
        @access_id ||= ApiAuth.access_id(request) || query_parameters[:access_id]
      end

      def not_check_signature?
        check_signature = query_parameters[:check_signature]
        check_signature.present? && check_signature.to_i.zero? && (Rails.env.staging? || !Rails.env.production?)
      end
    end
  end
end
