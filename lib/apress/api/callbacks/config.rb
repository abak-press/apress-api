require 'singleton'

module Apress
  module Api
    module Callbacks
      class Config
        include Singleton

        class << self
          delegate :add_service, :services, to: :instance
          delegate :allowed_client?, :add_client, to: :instance
          delegate :add_handler, :handlers, to: :instance
          delegate :valid_event?, to: :instance
        end

        def add_service(event:, service:)
          events[event] << service
        end

        def add_handler(service:, event:, handler:)
          (handlers_config[service][event] ||= []) << handler
        end

        def add_client(access_id)
          clients << access_id
        end

        def allowed_client?(client)
          clients.include?(client.access_id)
        end

        def services(event)
          events[event]
        end

        def handlers(service:, event:)
          handlers_config.fetch(service).fetch(event)
        end

        private

        def handlers_config
          @handlers_config ||= ::Hash.new { |hash, key| hash[key] = {} }
        end

        def events
          @events ||= ::Hash.new { |hash, key| hash[key] = [] }
        end

        def clients
          @clients ||= Set.new
        end
      end
    end
  end
end
