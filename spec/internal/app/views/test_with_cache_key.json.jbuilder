json.paginating_cache! @collection, ['v1', @collection], expire_in: 30.minutes, skip_digest: true do
  json.title 'test'
end
