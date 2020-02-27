require 'spec_helper'

def jbuild(source_key, collection)
  assign(:collection, collection)
  MultiJson.load(render(template: source_key))
end

def view_prefix
  if (Rails::VERSION::MAJOR == 5 && Rails::VERSION::MINOR == 2) ||
    (Rails::VERSION::MAJOR == 6 && Rails::VERSION::MINOR == 0)
    'jbuilder/views'
  else
    'jbuilder'
  end
end

describe 'paginating_cache', type: :view do
  let(:collection) { double(total_entries: 30, total_pages: 10, per_page: 5, current_page: 2, cache_key: 'test') }
  context 'when caching disabled' do
    it 'sets headers and yield view' do
      result = jbuild('test.json.jbuilder', collection)
      expect(result['title']).to eq 'test'
      expect(view.controller.response.headers['X-Total-Count']).to eq '30'
      expect(view.controller.response.headers['X-Total-Pages']).to eq '10'
      expect(view.controller.response.headers['X-Per-Page']).to eq '5'
      expect(view.controller.response.headers['X-Page']).to eq '2'
    end
  end

  context 'when caching enable' do
    before do
      view.controller.perform_caching = true
    end

    it 'cache result with collection key' do
      expect(Rails.cache).to receive(:fetch).with("#{view_prefix}/test", skip_digest: true).and_call_original

      jbuild('test.json.jbuilder', collection)
    end

    it 'cache results with custom composite key' do
      expect(Rails.cache).to \
        receive(:fetch).with("#{view_prefix}/v1/test", expire_in: 30.minutes, skip_digest: true).and_call_original

      jbuild('test_with_cache_key.json.jbuilder', collection)
    end

    it 'sets headers and yield view' do
      result = jbuild('test.json.jbuilder', collection)
      expect(result['title']).to eq 'test'
      expect(view.controller.response.headers['X-Total-Count']).to eq '30'
      expect(view.controller.response.headers['X-Total-Pages']).to eq '10'
    end
  end
end
