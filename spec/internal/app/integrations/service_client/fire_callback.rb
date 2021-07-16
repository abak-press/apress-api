# frozen_string_literal: true
module ServiceClient
  class FireCallback < Apress::Api::Callbacks::BaseCallback
    def call
      "Fired"
    end
  end
end
