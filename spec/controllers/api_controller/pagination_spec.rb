require "spec_helper"

describe Apress::Api::ApiController::Base, type: :controller do
  controller do
    def index
      render json: {status: "ok"}
    end
  end

  describe "#pagination_headers" do
    let(:collection) { double(total_entries: 30, total_pages: 10) }

    context "when auth successfull" do
      before do
        get :index
        controller.pagination_headers(collection)
      end

      it { expect(response.header["X-Total-Count"]).to eq '30' }
      it { expect(response.header["X-Total-Pages"]).to eq '10' }
    end
  end
end
