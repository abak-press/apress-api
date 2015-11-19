require "spec_helper"

describe Apress::Api::ApiController::Base, type: :controller do
  let(:client) { create "api/client" }
  let(:json) { JSON.parse(response.body) }

  describe '#render_json' do
    before do
      allow(controller).to receive(:authenticate)
      allow(controller).to receive(:current_api_client).and_return(client)
    end

    context 'with non-xhr request' do
      controller do
        def index
          render_json({payload: 'message'}, 400)
        end
      end

      it 'renders proper json' do
        get :index

        expect(response.status).to eq 400
        expect(json['status']).to be_nil
        expect(json['payload']).to eq 'message'
      end
    end

    context 'with xhr request' do
      controller do
        def index
          render_json({}, 400)
        end
      end

      it 'return 200 and render proper json' do
        xhr :get, :index

        expect(response.status).to eq 200
        expect(json['status']).to eq 400
      end
    end
  end
end
