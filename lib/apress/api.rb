require "active_support"
require "active_support/lazy_load_patch" if ActiveSupport::VERSION::MAJOR == 3 && ActiveSupport::VERSION::MINOR == 1
require "rails/all"
require "multi_json"
require "jbuilder"
require "api_auth"
require "attr_extras"
require 'apress/api/action_dispatch/routing/mapper'
require "apress/api/version"
require "apress/api/engine"
