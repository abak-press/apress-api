# frozen_string_literal: true
require 'spec_helper'

describe Apress::Api::EventHandlerEnqueueingJob, type: :job do
  describe '#perform' do
    let(:handler) { 'handler_job' }
    let(:event_params) { {id: 100_500} }

    it 'enqueues specified handler job' do
      expect(Resque).to receive(:enqueue).with(HandlerJob, event_params)

      described_class.perform(handler, event_params)
    end

    context 'with unknown handler job class' do
      let(:handler) { 'unknown_handler_job' }

      it do
        expect { described_class.perform(handler, event_params) }.to raise_error(NameError)
      end
    end

    context 'when handler job responds to enqueue method' do
      it 'enqueues specified handler job' do
        expect(HandlerJob).to receive(:enqueue).with(event_params)
        expect(Resque).to_not receive(:enqueue).with(HandlerJob, event_params)

        described_class.perform(handler, event_params)
      end
    end
  end
end
