require "spec_helper"

def form_params(p)
  if Rails::VERSION::MAJOR > 4
    {params: p}
  else
    p
  end
end

describe Apress::Api::V1::CallbacksController, type: :controller do
  let!(:client) { create "api/client" }
  before do
    allow(controller).to receive(:authenticate)
    allow(controller).to receive(:current_api_client).and_return(client)
  end

  describe "#create" do
    context "when client present and allowed" do
      before do
        client.update_attributes(access_id: 'service_access_id')
      end

      context 'when params are valid' do
        it 'calls enqueueing job for each handler' do
          expect(Resque).to receive(:enqueue).with(Apress::Api::EventHandlerEnqueueingJob, 'handler_job', {})
          expect(Resque).to receive(:enqueue).with(Apress::Api::EventHandlerEnqueueingJob, 'second_handler_job', {})
          post :create, form_params(service: 'external_service', event: 'other_event')
          expect(response.status).to eq 201
        end
      end

      context 'when job is missing' do
        it 'raises KeyError' do
          expect do
            post :create, form_params(service: 'service', event: 'some_event')
          end.to raise_error(KeyError)
        end
      end
    end

    context "when client isn't allowed" do
      it 'returns 403' do
        post :create, form_params(service: 'service', event: 'some_event')

        expect(response.status).to eq 403
      end
    end
  end
end
