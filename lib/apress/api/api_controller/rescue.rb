module Apress
  module Api
    module ApiController
      module Rescue
        extend ActiveSupport::Concern

        included do
          rescue_from "Exception", with: :server_error if Rails.env.production?

          rescue_from "Pundit::NotAuthorizedError", with: :forbidden

          rescue_from "ActiveRecord::RecordNotFound",
                      "ActionController::ParameterMissing",
                      "ActionView::MissingTemplate",
                      "ActionController::UnknownFormat",
                      "ActiveRecord::SubclassNotFound",
                      with: :not_found unless Rails.env.development?

          rescue_from 'ActiveRecord::RecordInvalid', with: :unprocessable

          helper_method :show_errors?
        end

        private

        def server_error(exception)
          render_error(500, exception)
        end

        def not_found(exception = nil)
          render_error(404, exception)
        end

        def forbidden(exception = nil)
          render_error(403, exception)
        end

        def bad_request(exception = nil)
          render_error(400, exception)
        end

        def unprocessable(exception_or_errors)
          @errors =
            if exception_or_errors.respond_to?(:record)
              exception_or_errors.record.errors
            else
              exception_or_errors
            end
          @errors = Array.wrap(@errors)
          render 'apress/api/shared/unproccesable_errors', status: 422
        end

        def render_error(status, exception = nil)
          @status = status
          @exception = exception

          log_error(exception) if exception

          render "apress/api/shared/error", status: status
        end

        def log_error(exception)
          Rails.logger.error(exception.message)
          Rails.logger.error(exception.backtrace.join("/n")) if exception.backtrace.present?
        end

        def show_errors?
          soft_environment?
        end

        def soft_environment?
          Rails.env.staging? || !Rails.env.production?
        end
      end
    end
  end
end
