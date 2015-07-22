require "spec_helper"

describe Apress::Api::ApiController::Base, type: :controller do
  controller do
    def index
      render json: {status: "ok"}
    end
  end

  let(:client) { create "api/client" }

  describe "#authenticate" do
    before do
      class_double(Apress::Api::AuthService, new: auth_service).as_stubbed_const
    end

    context "when auth successfull" do
      let(:auth_service) { double("auth_service", call: true, client: client) }

      it do
        get :index
        expect(response.status).to eq 200
        expect(controller.current_api_client).to eq client
      end
    end

    context "when auth failed" do
      let(:auth_service) { double("auth_service", call: false, client: nil) }

      it do
        get :index
        expect(response.status).to eq 403
        expect(controller.current_api_client).to be nil
      end
    end
  end
end
