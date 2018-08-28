module Apress
  module Api
    class DeprecatedVersionsController < ApiController::Base
      if (Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR == 2) || Rails::VERSION::MAJOR > 4
        skip_before_action :authenticate, only: :show
      else
        skip_before_filter :authenticate, only: :show
      end

      def show
        render_error(410)
      end
    end
  end
end
