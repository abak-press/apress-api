require "spec_helper"

describe Apress::Api::DeprecatedVersionsController, type: :controller do
  describe "#show" do
    it "returns 410" do
      get :show
      expect(response.status).to eq 410
    end
  end
end
