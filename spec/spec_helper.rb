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
Combustion.initialize! :all

require "rspec/rails"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.use_transactional_fixtures = true
end
