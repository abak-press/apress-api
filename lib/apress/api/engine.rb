module Apress
  module Api
    class Engine < Rails::Engine
      config.autoload_paths << config.root.join("lib")

      initializer "apress-api", before: :load_init_rb do |app|
        app.config.paths["db/migrate"].concat(config.paths["db/migrate"].expanded)

        app.config.api = {
          secret_token_ttl: 1.hour,
          refresh_token_ttl: 1.week
        }

        ::MultiJson.use :oj

        JbuilderTemplate.send :include, Apress::Api::Extensions::Jbuilder::JbuilderTemplate
      end

      initializer "apress-api-factories", after: "factory_girl.set_factory_paths" do
        if defined?(FactoryGirl)
          FactoryGirl.definition_file_paths.unshift root.join("spec", "factories")
        end
      end
    end
  end
end
