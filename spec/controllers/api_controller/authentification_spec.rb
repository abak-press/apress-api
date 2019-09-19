require "spec_helper"

describe Apress::Api::ApiController::Base, type: :controller do
  let(:client) { create "api/client" }

  context "when api client is required, by default" do
    controller do
      def index
        render json: {status: "ok"}
      end
    end

    describe "#authenticate" do
      before do
        class_double(Apress::Api::AuthService, new: auth_service).as_stubbed_const
      end

      context "when auth successfull" do
        let(:auth_service) { double("auth_service", call: true, client: client) }

        it "assigns current_api_client" do
          get :index
          expect(response.status).to eq 200
          expect(controller.current_api_client).to eq client
        end
      end

      context "when auth failed" do
        let(:auth_service) { double("auth_service", call: false, client: nil) }

        it "returns 401" do
          get :index
          expect(response.status).to eq 401
          expect(controller.current_api_client).to be nil
        end
      end
    end
  end

  context "when api client is optional" do
    controller do
      if (Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR == 2) || Rails::VERSION::MAJOR > 4
        skip_before_action :authenticate
      else
        skip_before_filter :authenticate
      end

      def index
        render json: {status: "ok"}
      end
    end

    describe "#authenticate" do
      before do
        class_double(Apress::Api::AuthService, new: auth_service).as_stubbed_const
      end

      context "when auth successfull" do
        let(:auth_service) { double("auth_service", call: true, client: client) }

        it "assigns current_api_client" do
          get :index
          expect(response.status).to eq 200
          expect(controller.current_api_client).to eq client
        end
      end

      context "when auth failed" do
        let(:auth_service) { double("auth_service", call: false, client: nil) }

        it "returns 200 and not assign current_api_client" do
          get :index
          expect(response.status).to eq 200
          expect(controller.current_api_client).to be nil
        end
      end
    end
  end
end
