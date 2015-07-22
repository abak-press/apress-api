json.client do
  json.partial! partial: "apress/api/v1/clients/client", locals: {client: @client}
  json.(@client, :secret_token, :refresh_token)
end
