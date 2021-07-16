# frozen_string_literal: true
require "spec_helper"
require "rack/request"
require "rack/mock"

describe Apress::Api::AuthService do
  let(:request) { Rack::Request.new(Rack::MockRequest.env_for("/", "HTTP_HOST" => "ex.com")) }
  let(:service) { described_class.new(request) }
  let(:client) { create "api/client" }
  let(:params) { {} }

  before do
    allow(request).to receive(:query_parameters).and_return(params)
  end

  context "when client not found" do
    it { expect(service.call).to be false }
  end

  context "when find client from headers" do
    it do
      ApiAuth.sign!(request, client.access_id, client.secret_token)
      service.call
      expect(service.client).to eq client
    end
  end

  context "when find client from query params" do
    let(:params) { {access_id: client.access_id} }

    it do
      service.call
      expect(service.client).to eq client
    end
  end

  context "when secret token expired" do
    it do
      client
      Timecop.freeze(1.year.since)
      ApiAuth.sign!(request, client.access_id, client.secret_token)

      expect(service.call).to be false

      Timecop.return
    end
  end

  context "when not check signature" do
    let(:params) { {access_id: client.access_id, check_signature: 0} }

    context "when rails env production" do
      it do
        allow(Rails.env).to receive(:production?).and_return(true)
        expect(service.call).to be false
      end
    end

    context "when rails env not production" do
      it do
        expect(service.call).to be true
      end
    end
  end
end
