# frozen_string_literal: true
json.error do
  json.message exception.message
  json.backtrace exception.backtrace
end
