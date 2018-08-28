require "bundler/setup"
require 'pry-byebug'

require "simplecov"
SimpleCov.start "rails" do
  minimum_coverage 95
  add_filter "/lib/apress/api/rspec"
  add_filter "/lib/apress/api/testing/"
  add_filter "/lib/apress/api/swagger/"
  add_filter "/app/docs"
end

require "apress/api"

require 'mock_redis'
redis = MockRedis.new
Resque.redis = redis

require "factory_girl_rails"
require "timecop"
require "combustion"

Combustion.initialize! :all do
  config.cache_store = :null_store if defined?(ActiveSupport::Cache::NullStore)
end

require "rails-controller-testing" if Rails::VERSION::MAJOR > 4
require "rspec/rails"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.use_transactional_fixtures = true
end
