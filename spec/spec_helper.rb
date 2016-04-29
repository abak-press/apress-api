require "bundler/setup"

require "simplecov"
SimpleCov.start "rails" do
  minimum_coverage 95
  add_filter "/lib/apress/api/testing/"
end

require "pry-debugger"
require "apress/api"

require "factory_girl_rails"
require "timecop"
require "combustion"
Combustion.initialize! :all do
  config.cache_store = :null_store if defined?(ActiveSupport::Cache::NullStore)
end

require "rspec/rails"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.use_transactional_fixtures = true
end
