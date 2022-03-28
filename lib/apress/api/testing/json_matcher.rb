# frozen_string_literal: true
require 'json-schema'
require 'rspec/expectations'

RSpec::Matchers.define :match_json_schema do |schema, options|
  match do |json|
    options = {strict: true}.merge!(options || {})
    JSON::Validator.validate!(schema, json, options)
  end
end

# Defines rspec matcher to check expected json matches swagger model schema
#
# Examples
#
#   it 'expect response body is similar to swagger doc' do
#     expect(response.body).to match_swagger_schema('Swagger::V1::YourCustomSchema')
#   end
RSpec::Matchers.define :match_swagger_schema do |expected|
  match do |actual|
    schema = swagger_schema[:definitions][swagger_model_name]
    raise "Swagger schema #{swagger_model_name} does not exists" if schema.nil?

    match_json_schema(schema).match(expected)
  end

  description do
    "matches swagger documentation schema #{swagger_model_name}"
  end

  failure_message do |actual|
    "expected #{actual} to match swagger schema #{swagger_model_name}"
  end

  failure_message_when_negated do |actual|
    "expected #{actual} not to match swagger schema #{swagger_model_name}"
  end

  def swagger_schema
    @swagger_schema ||= Apress::Api::Swagger::Generator.new.data
  end

  def swagger_model_name
    case expected
    when Class
      expected.name.to_sym
    when String
      expected.to_sym
    else
      expected
    end
  end
end
