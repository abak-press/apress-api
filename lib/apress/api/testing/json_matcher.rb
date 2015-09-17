require 'json-schema'
require 'rspec/expectations'

RSpec::Matchers.define :match_json_schema do |schema, options|
  match do |json|
    options = {strict: true}.merge!(options || {})
    JSON::Validator.validate!(schema, json, options)
  end
end