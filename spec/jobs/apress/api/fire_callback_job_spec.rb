require 'spec_helper'

describe Apress::Api::FireCallbackJob, type: :job do
  let(:params) { {test: 1} }

  describe '#perform' do
    let(:event) { 'some_event' }
    context 'when all goind well' do
      it 'calls correct service' do
        expect(ServiceClient::FireCallback).to receive(:call!).with(event: event, params: params)

        described_class.perform("service", event, params)
      end
    end

    context 'in case error' do
      let(:event) { 'some_error_event' }
      it 'throws Callbacks::Error' do
        expect do
          described_class.perform("error", event, params)
        end.to raise_error(Apress::Api::Callbacks::FireCallbackError)
      end
    end
  end
end
