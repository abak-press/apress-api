module Apress
  module Api
    class Engine < Rails::Engine
      config.autoload_paths << config.root.join("lib")
      config.paths.add 'app/docs', :eager_load => true

      initializer "apress-api", before: :load_init_rb do |app|
        app.config.paths["db/migrate"].concat(config.paths["db/migrate"].expanded)

        glob = config.root.join('app/docs/**/*.rb')
        app.config.to_prepare do
          Dir[glob].each { |file| require_dependency file }
        end

        app.config.api = {
          secret_token_ttl: 1.hour,
          refresh_token_ttl: 1.week,
          v1_doc_path: 'docs/swagger/v1.json'
        }

        ::MultiJson.use :oj

        JbuilderTemplate.send :include, Apress::Api::Extensions::Jbuilder::JbuilderTemplate

        if File.exist?(app.root.join('config', 'app_clients_versions.yml'))
          app.middleware.use Apress::Api::Middleware::MobileVersion
        end
      end

      initializer "apress-api-factories", after: "factory_girl.set_factory_paths" do
        if defined?(FactoryGirl)
          FactoryGirl.definition_file_paths.unshift root.join("spec", "factories")
        end
      end
    end
  end
end
