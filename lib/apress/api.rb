require 'rails'
require "active_support"
require "active_support/lazy_load_patch" if ActiveSupport::VERSION::MAJOR == 3 && ActiveSupport::VERSION::MINOR == 1
require "multi_json"
require "jbuilder"
require "api_auth"
require "attr_extras"
require 'interactor'
require 'pundit'
require 'swagger/blocks'
require 'resque/integration'
require 'apress/documentation'
require "apress/api/version"
require "apress/api/engine"

module Apress
  module Api
    module Swagger
      def self.const_missing(name)
        ::Apress::Documentation::Swagger.const_get(name)
      end
    end
  end
end
