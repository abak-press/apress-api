require "spec_helper"

describe Apress::Api::ApiController::Base, type: :controller do
  before do
    allow(controller).to receive(:collection).and_return(collection)
  end

  describe "#pagination_headers" do
    context 'with caching' do
      controller do
        skip_before_filter :authenticate, only: :index

        def index
          pagination_headers(collection, cache_tags: :tag, expire_in: 30.minutes)
        end
      end

      let(:cache_key) { :key }
      let(:collection) { double(cache_key: cache_key, total_entries: 30, total_pages: 10) }
      it 'sets right headers' do
        get :index

        expect(response.header["X-Total-Count"]).to eq '30'
        expect(response.header["X-Total-Pages"]).to eq '10'
      end

      it 'cache results' do
        expect(Rails.cache).to \
          receive(:fetch).with("#{cache_key}/total_entries", cache_tags: :tag, expire_in: 30.minutes)
        expect(Rails.cache).to \
          receive(:fetch).with("#{cache_key}/total_pages", cache_tags: :tag, expire_in: 30.minutes)

        get :index
      end
    end

    context 'without caching' do
      let(:collection) { double(total_entries: 30, total_pages: 10) }
      controller do
        skip_before_filter :authenticate, only: :index

        def index
          pagination_headers(collection)
        end
      end

      it 'sets right headers' do
        get :index

        expect(response.header["X-Total-Count"]).to eq '30'
        expect(response.header["X-Total-Pages"]).to eq '10'
      end
    end
  end
end
