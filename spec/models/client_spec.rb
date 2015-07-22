require "spec_helper"

describe Apress::Api::Client do
  let(:client) { create "api/client" }

  describe "#regenerate_tokens" do
    it "regenerates secret and refresh tokens" do
      client.regenerate_tokens

      expect(client.changed).
        to match_array %w(secret_token secret_token_expire_at refresh_token refresh_token_expire_at)
    end
  end

  describe "#regenerate_tokens!" do
    it "regenerates secret and refresh tokens and save" do
      attrs_names = %w(secret_token secret_token_expire_at refresh_token refresh_token_expire_at)
      was_attrs = client.attributes.slice(*attrs_names).values
      client.regenerate_tokens!

      expect(client.attributes.slice(*attrs_names).values).to_not include(was_attrs)
      expect(client.changed?).to be false
    end
  end
end
