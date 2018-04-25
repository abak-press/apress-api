module ErrorClient
  class FireCallback < Apress::Api::Callbacks::BaseCallback
    class RepeatError < StandardError
    end
    add_retry_exceptions ArgumentError
    add_repeat_exceptions RepeatError

    delegate :event, to: :context
    def call
      raise RepeatError if event == 'repeat_error'
      raise ArgumentError
    end
  end
end
