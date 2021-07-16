# coding: utf-8
# frozen_string_literal: true
require 'rspec/core'
require 'rspec/expectations'
require 'swagger'

require_relative 'rspec/utils'

RSpec::Matchers.define :correspond_to_schema do |schema, options|
  match do |response|
    if schema.present?
      options ||= {}
      JSON::Validator.validate!(schema, response.body.to_s, options)
    else
      true
    end
  end
end

# NOTE: Для того, чтобы находить нужную спецификацию ресурса по конкретному запросу (request.path),
#       нужно уметь находить соответсвие Path -> URITemplatePath
RSpec.shared_examples 'an api response' do |status|
  let(:method) { request.method.downcase.to_sym }
  let(:schema) do
    begin
      schema = @api.paths[resource][method].responses[response.code].schema
      schema.definitions = @api.definitions if schema.present?
      schema
    rescue
      fail "Swagger schema does not exist: #{dump_response}"
    end
  end

  it { expect(response).to have_http_status(status).and correspond_to_schema(schema) }
end

RSpec.configure do |c|
  c.include Apress::Api::Rspec::Utils, type: :request

  c.before(:context, :api) do
    classes = Apress::Api::Swagger::Schema.swagger_classes
    @swagger_schema = ::Swagger::Blocks.build_root_json(classes)
    @api = Swagger.build(@swagger_schema.to_json, format: :json)
  end

  c.after(:example, :verbose, type: :request) do
    puts dump_response
  end
end
