require "spec_helper"

describe Apress::Api::ApiController::Base, type: :controller do
  render_views

  let(:client) { create "api/client" }
  let(:json) { JSON.parse(response.body) }

  before do
    allow(controller).to receive(:authenticate)
    allow(controller).to receive(:current_api_client).and_return(client)
  end

  describe "#render_error" do

    context "when exception given" do
      controller do
        def index
          exception = ArgumentError.new(:message)
          exception.set_backtrace(%w(path/to/file))
          render_error(400, exception)
        end
      end

      it do
        get :index

        expect(response.status).to eq 400
        expect(json["status"]).to eq 400
        expect(json["error"]["message"]).to eq "message"
        expect(json["error"]["backtrace"][0]).to eq "path/to/file"
      end
    end

    context "when server error" do
      controller do
        def index
          exception = ArgumentError.new(:message)
          exception.set_backtrace(%w(path/to/file))
          server_error(exception)
        end
      end

      it do
        get :index

        expect(response.status).to eq 500
        expect(json["status"]).to eq 500
        expect(json["error"]["message"]).to eq "message"
        expect(json["error"]["backtrace"][0]).to eq "path/to/file"
      end
    end

    context "when no exception" do
      controller do
        def index
          not_found
        end
      end

      it do
        get :index

        expect(response.status).to eq 404
        expect(json["status"]).to eq 404
        expect(json["error"]).to be nil
      end
    end
  end

  describe '#unproccesable' do
    let(:record) { build 'api/client' }

    before do
      record.errors.add(:access_id, 'empty')
      allow(controller).to receive(:record).and_return(record)
    end

    context 'when rescued from exeption' do
      controller do
        def index
          raise ActiveRecord::RecordInvalid.new(record)
        end
      end

      it 'renders errors' do
        get :index

        expect(response.status).to eq 422
        expect(json['errors']).to eq [{"access_id" => "empty"}]
      end
    end

    context 'when called from action' do
      controller do
        def index
          unprocessable(record.errors)
        end
      end

      it 'renders errors' do
        get :index

        expect(response.status).to eq 422
        expect(json['errors']).to eq [{"access_id" => "empty"}]
      end
    end

    context 'when called from action with multiple errors' do
      controller do
        def index
          unprocessable([record.errors, 'other' => 'error'])
        end
      end

      it 'renders errors' do
        get :index

        expect(response.status).to eq 422
        expect(json['errors']).to eq [{"access_id" => "empty"}, {'other' => 'error'}]
      end
    end
  end
end
