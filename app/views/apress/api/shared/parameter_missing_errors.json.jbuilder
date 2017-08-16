json.status @status

json.errors do
  json.array! @errors do |error|
    error.each do |k, v|
      json.set! k, v
    end
  end
end
