require 'rails/engine'

module Apress
  module Api
    class Engine < Rails::Engine
      config.autoload_paths << config.root.join("lib")
      config.paths.add 'app/docs', eager_load: false

      Apress::Documentation.add_load_path(config.root.join('app/docs'))

      initializer "apress-api", before: :load_init_rb do |app|
        app.config.paths["db/migrate"].concat(config.paths["db/migrate"].expanded)

        app.config.api = {
          secret_token_ttl: 1.hour,
          refresh_token_ttl: 1.week,
          v1_doc_path: 'docs/swagger/v1.json'
        }

        ::MultiJson.use :oj

        require 'jbuilder/jbuilder_template'
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
