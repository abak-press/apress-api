require 'spec_helper'

describe Apress::Api::DelayedFireCallback, type: :interactor do
  let(:result) { described_class.call(event: 'some_event', params: {test: 1}) }

  describe '#call' do
    it 'calls job with correct params' do
      expect(Resque).to receive(:enqueue).with(
        ::Apress::Api::FireCallbackJob,
        'service',
        'some_event',
        test: 1
      )

      result
    end

    context 'when multiple services' do
      before do
        allow(Apress::Api::Callbacks::Config).to \
          receive(:services).with('some_event').and_return(%w(service_1 service_2))
      end

      it 'calls 2 jobs' do
        expect(Resque).to receive(:enqueue).with(
          ::Apress::Api::FireCallbackJob,
          'service_1',
          'some_event',
          test: 1
        )

        expect(Resque).to receive(:enqueue).with(
          ::Apress::Api::FireCallbackJob,
          'service_2',
          'some_event',
          test: 1
        )

        result
      end
    end
  end
end
