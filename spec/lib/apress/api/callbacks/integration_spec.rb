require 'spec_helper'

describe Apress::Api::Callbacks::Integration, type: :mixin do
  describe '#notify_service' do
    context 'when callback is set' do
      let(:model) { DummyModel.new }
      it 'calls delayed interactor' do
        expect(Apress::Api::DelayedFireCallback).to receive(:call!).with(event: 'some_event', params: {name: nil})

        model.save
      end
    end

    context 'when params are lambda' do
      let(:model) { DummyModel.create!(name: 'test') }
      it 'calls delayed interactor' do
        expect(Apress::Api::DelayedFireCallback).to \
          receive(:call!).with(event: 'dynamic_params_event', params: {name: 'test_2 stuff'})

        model.update(name: 'test_2')
      end
    end
  end
end
