module Apress
  module Api
    module Middleware
      class ClientAppMinVersion
        def initialize(app)
          @app = app
        end

        def call(env)
          app_id = env['HTTP_APP_ID'] && env['HTTP_APP_ID'].downcase

          status, headers, body = @app.call(env)

          if app = ::Apress::Api::ClientsAppVersion.find_by(app: app_id)
            headers['app-min-version'] = app.version
          end

          [status, headers, body]
        end
      end
    end
  end
end
