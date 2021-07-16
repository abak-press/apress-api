# frozen_string_literal: true
module Apress
  module Api
    class Client < ActiveRecord::Base
      self.table_name = "api_clients"

      validates :access_id, presence: true
      validates :secret_token, presence: true
      validates :secret_token_expire_at, presence: true
      validates :refresh_token, presence: true
      validates :refresh_token_expire_at, presence: true

      before_validation :generate_access_id, on: :create
      before_validation :regenerate_tokens, on: :create

      def regenerate_tokens
        generate_secret_token
        set_secret_token_expiration
        generate_refresh_token
        set_refresh_token_expiration
      end

      def regenerate_tokens!
        regenerate_tokens
        save!
      end

      def refresh_token_expired?
        refresh_token_expire_at < Time.now.utc
      end

      def secret_token_expired?
        secret_token_expire_at < Time.now.utc
      end

      private

      def generate_access_id
        self.access_id = SecureRandom.uuid
      end

      def generate_secret_token
        self.secret_token = ::ApiAuth.generate_secret_key
      end

      def set_secret_token_expiration
        self.secret_token_expire_at = Rails.application.config.api[:secret_token_ttl].from_now
      end

      def generate_refresh_token
        self.refresh_token = ::ApiAuth.generate_secret_key
      end

      def set_refresh_token_expiration
        self.refresh_token_expire_at = Rails.application.config.api[:refresh_token_ttl].from_now
      end

      ActiveSupport.run_load_hooks(:"apress/api/client", self)
    end
  end
end
