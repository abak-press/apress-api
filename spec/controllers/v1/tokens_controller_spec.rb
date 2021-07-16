# frozen_string_literal: true
require "spec_helper"

def form_params(p)
  if Rails::VERSION::MAJOR > 4
    {params: p}
  else
    p
  end
end

describe Apress::Api::V1::TokensController, type: :controller do
  render_views

  let!(:client) { create "api/client" }

  describe "#create" do
    context "when client doesn't exist" do
      it do
        post :create, form_params(client_id: "no-name")
        expect(response.status).to eq 404
      end
    end

    context "when refresh token not valid" do
      it do
        post :create, form_params(client_id: client.access_id, refresh_token: "bad-token")
        expect(response.status).to eq 400
      end
    end

    context "when refresh token expired" do
      it do
        Timecop.travel(1.year.from_now)
        post :create, form_params(client_id: client.access_id, refresh_token: client.refresh_token)
        expect(response.status).to eq 403
        Timecop.return
      end
    end

    context "when refresh token is valid" do
      it "returns regenerated tokens" do
        post :create, form_params(client_id: client.access_id, refresh_token: client.refresh_token)
        expect(response.status).to eq 200

        client.reload
        json = JSON.parse(response.body)

        expect(json["client"]["secret_token"]).to eq client.secret_token
        expect(json["client"]["refresh_token"]).to eq client.refresh_token
      end
    end
  end
end
