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
    let(:current_page) { 1 }
    let(:collection) do
      double(
        total_entries: 30,
        total_pages: 3,
        per_page: 10,
        current_page: current_page
      )
    end

    context 'when there are no other values in Link header' do
      controller do
        skip_before_filter :authenticate

        def index
          pagination_headers(collection)
          render json: {status: 'ok'}
        end
      end

      before do
        allow(controller).to receive(:collection).and_return(collection)
        get :index
      end

      it 'sets correct X-Total-Count header' do
        expect(response.header['X-Total-Count']).to eq '30'
      end

      it 'sets correct X-Total-Pages header' do
        expect(response.header['X-Total-Pages']).to eq '3'
      end

      it 'sets correct X-Per-Page header' do
        expect(response.header['X-Per-Page']).to eq '10'
      end

      context 'when current page is a first page' do
        it 'sets correct X-Page header' do
          expect(response.header['X-Page']).to eq '1'
        end

        it 'does not add pagination links for first and previous pages to Link header' do
          expect(response.header['Link'].to_s).not_to include('rel="first"', 'rel="prev"')
        end

        it 'adds pagination links for next and last pages to Link header' do
          expect(response.header['Link'].to_s.split(', ')).to include(
            %(<#{request.url}?page=2>; rel="next"),
            %(<#{request.url}?page=3>; rel="last")
          )
        end
      end

      context 'when current page is somewhere in the middle' do
        let(:current_page) { 2 }

        it 'sets correct X-Page header' do
          expect(response.header['X-Page']).to eq '2'
        end

        it 'adds pagination links for first, previous, next and last pages to Link header' do
          expect(response.header['Link'].to_s.split(', ')).to include(
            %(<#{request.url}?page=1>; rel="first"),
            %(<#{request.url}?page=1>; rel="prev"),
            %(<#{request.url}?page=3>; rel="next"),
            %(<#{request.url}?page=3>; rel="last")
          )
        end
      end

      context 'when current page is a last page' do
        it 'sets correct X-Page header' do
          expect(response.header['X-Page']).to eq '3'
        end

        let(:current_page) { 3 }

        it 'does not add pagination links for next and last pages to Link header' do
          expect(response.header['Link'].to_s).not_to include('rel="next"', 'rel="last"')
        end

        it 'adds pagination links for first and previous pages to Link header' do
          expect(response.header['Link'].to_s.split(', ')).to include(
            %(<#{request.url}?page=1>; rel="first"),
            %(<#{request.url}?page=2>; rel="prev")
          )
        end
      end

      context 'when there is only one page' do
        let(:collection) do
          double(
            total_entries: 9,
            total_pages: 1,
            per_page: 10,
            current_page: 1
          )
        end

        it 'does not add pagination links to Link header' do
          expect(response.header['Link'].to_s).not_to include('rel="first"', 'rel="prev"', 'rel="last"', 'rel="next"')
        end
      end
    end

    context 'when Link header already has some values' do
      controller do
        skip_before_filter :authenticate

        def index
          headers['Link'] = '<http://test.host/help>; rel="help"'

          pagination_headers(collection)
          render json: {status: 'ok'}
        end
      end

      let(:current_page) { 2 }

      before do
        allow(controller).to receive(:collection).and_return(collection)
      end

      it do
        expect { get :index }.to raise_error(Apress::Api::ApiController::Pagination::LinkHeaderAppendNotImplemented)
      end
    end
  end
end
