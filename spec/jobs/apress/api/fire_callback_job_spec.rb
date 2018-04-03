require 'spec_helper'

describe Apress::Api::FireCallbackJob, type: :job do
  describe '#perform' do
    let(:event) { 'some_event' }
    let(:params) { {test: 1} }
    it 'calls correct service' do
      expect(ServiceClient::FireCallback).to receive(:call!).with(event: event, params: params)

      described_class.perform("service", event, params)
    end
  end
end
