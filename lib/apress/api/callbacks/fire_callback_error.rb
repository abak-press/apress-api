# frozen_string_literal: true
module Apress
  module Api
    module Callbacks
      class FireCallbackError < StandardError
        def initialize(message, backtrace)
          super(message)
          set_backtrace(backtrace)
        end
      end
    end
  end
end
