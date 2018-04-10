module ErrorClient
  class FireCallback < Apress::Api::Callbacks::BaseCallback
    add_retry_exceptions ArgumentError

    def call
      raise ArgumentError
    end
  end
end
