module Apress
  module Api
    module ApiController
      class Base < ActionController::Metal
        abstract!

        if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR > 0
          include AbstractController::Rendering
          include ActionView::Rendering
        end
        include ActionController::HideActions if Rails::VERSION::MAJOR < 5
        include ActionController::UrlFor
        include ActionController::Redirecting
        include ActionController::Rendering
        include ActionController::Renderers::All
        include ActionController::ConditionalGet
        include ActionController::RackDelegation
        include ActionController::ForceSSL
        include AbstractController::Callbacks
        include ActionController::Rescue
        include ActionController::Instrumentation
        include ActionController::StrongParameters if Rails::VERSION::MAJOR >= 4
        include ActionController::MimeResponds
        include ActionController::ImplicitRender

        # https://github.com/rails/strong_parameters/pull/199
        if Rails::VERSION::MAJOR == 3
          require "strong_parameters"
          require "strong_parameters/version"
        end

        if defined?(StrongParameters::VERSION) &&
          Gem::Version.new(StrongParameters::VERSION) <= Gem::Version.new("0.2.3")
          include ActionController::StrongParameters
        end

        extend Compatibility
        include Rescue
        include Responds
        include Authentification

        ActiveSupport.run_load_hooks(:action_controller, self)
        ActiveSupport.run_load_hooks(:"apress/api/api_controller", self)
      end
    end
  end
end
