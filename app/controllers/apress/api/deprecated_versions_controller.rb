module Apress
  module Api
    class DeprecatedVersionsController < ApiController::Base
      skip_before_filter :authenticate, only: :show

      def show
        render_error(410)
      end
    end
  end
end
