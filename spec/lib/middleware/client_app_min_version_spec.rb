require 'spec_helper'

describe Apress::Api::Middleware::ClientAppMinVersion do
  let(:app) { described_class.new(backend) }
  let(:backend) { lambda {|env| [200, {}, ['OK']]} }
  context 'when header app_id present' do
    let(:env) { { 'HTTP_APP_ID' => 'IOS' } }

    it 'return mobile version header' do
      _, headers, _ =  app.call(env)

      expect(headers['app-min-version']).to eq '1.0.0'
    end
  end

  context "when header app_id isn't given" do
    let(:env) { { } }

    it 'return mobile version header' do
      _, headers, _ = app.call(env)

      expect(headers['app-min-version']).not_to be
    end
  end

  context 'when app_id is invalid' do
    let(:env) { {'HTTP_APP_ID' => 'Some app'} }

    it 'return mobile version header' do
      _, headers, _ = app.call(env)

      expect(headers['app-min-version']).not_to be
    end
  end
end
