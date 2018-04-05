require 'singleton'

module Apress
  module Api
    module Callbacks
      class Config
        include Singleton

        class << self
          delegate :add_service, :services, to: :instance
          delegate :allowed_client?, :add_client, to: :instance
          delegate :add_handler, :handler, to: :instance
          delegate :valid_event?, to: :instance
        end

        def add_service(event:, service:)
          events[event] << service
        end

        def add_handler(service:, event:, handler:)
          handlers[service][event] = handler
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

        def handler(service:, event:)
          handlers.fetch(service).fetch(event)
        end

        private

        def handlers
          @handlers ||= ::Hash.new { |hash, key| hash[key] = {} }
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
