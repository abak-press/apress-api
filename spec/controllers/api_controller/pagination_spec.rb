require "spec_helper"

describe Apress::Api::ApiController::Base, type: :controller do
  describe '#prepare_pagination' do
    controller do
      skip_before_filter :authenticate

      def index
        prepare_pagination(per_page: {max: 100, default: 40})
        head 204
      end
    end

    context 'when params present' do
      context 'when params are valid' do
        it 'sets variables' do
          get :index, page: 2, per_page: 5

          expect(assigns(:page)).to eq 2
          expect(assigns(:per_page)).to eq 5
        end
      end

      context 'when params are invalid' do
        it 'returns 400 for negative page' do
          get :index, page: -1

          expect(response.status).to eq 400
        end

        it 'returns 400 for > max per_page value' do
          get :index, per_page: 101

          expect(response.status).to eq 400
        end
      end
    end

    context 'when no params are set' do
      it 'sets defaults' do
        get :index

        expect(assigns(:page)).to eq 1
        expect(assigns(:per_page)).to eq 40
      end
    end
  end

  describe "#pagination_headers" do
    let(:collection) { double(total_entries: 30, total_pages: 10) }

    controller do
      def index
        render json: {status: "ok"}
      end
    end

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
