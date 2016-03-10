module ActionDispatch
  module Routing
    class Mapper
      def api_namespace(options)
        versions = options.fetch(:versions)
        current = versions.is_a?(Array) ? versions.last : versions

        current_api_routes = lambda do
          yield
        end

        namespace :api, defaults: {format: :json} do
          if versions.is_a?(Array)
            versions.each do |version|
              scope module: version, &current_api_routes
            end
          else
            scope module: versions, &current_api_routes
          end

          namespace current, &current_api_routes
        end
      end
    end
  end
end
