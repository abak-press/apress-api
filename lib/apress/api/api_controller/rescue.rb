module Apress
  module Api
    module ApiController
      module Rescue
        extend ActiveSupport::Concern

        included do
          rescue_from "Exception", :server_error if Rails.env.production?

          rescue_from(
            "ActiveRecord::RecordNotFound",
            "ActionController::ParameterMissing",
            "ActionView::MissingTemplate",
            "ActionController::UnknownFormat",
            "ActiveRecord::SubclassNotFound") do |exception|
            render_error(404, exception)
          end unless Rails.env.development?
        end

        private

        def server_error(exception)
          render_error(500, exception)
        end

        def not_found
          render_error(404)
        end

        def forbidden
          render_error(403)
        end

        def bad_request
          render_error(400)
        end

        def render_error(status, exception = nil)
          payload = {status: status}

          if exception
            payload[:error] = exception.message
            payload[:backtrace] = exception.backtrace if error_backtrace?(exception)
            log_error(exception)
          end

          render json: payload, status: request.xhr? ? 200 : status
        end

        def log_error(exception)
          Rails.logger.error(exception.message)
          Rails.logger.error(exception.backtrace.join("/n")) if error_backtrace?(exception)
        end

        def error_backtrace?(exception)
          exception.backtrace && (Rails.env.staging? || !Rails.env.production?)
        end
      end
    end
  end
end
