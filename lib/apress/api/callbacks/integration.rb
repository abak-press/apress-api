# frozen_string_literal: true
module Apress
  module Api
    module Callbacks
      module Integration
        extend ActiveSupport::Concern

        module ClassMethods
          def notify_services(event:, params: {}, at:)
            at = Array.wrap(at)
            callback = at.shift

            public_send(callback, *at) do
              hash_params =
                if params.respond_to?(:call)
                  params.call(self)
                else
                  params.each_with_object({}) do |param, hash|
                    hash[param] = public_send(param)
                  end
                end
              ::Apress::Api::DelayedFireCallback.call!(event: event, params: hash_params)
            end
          end
        end
      end
    end
  end
end
