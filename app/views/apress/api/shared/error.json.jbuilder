json.status @status

if @exception && show_errors?
  json.partial! partial: "apress/api/shared/exception", locals: {exception: @exception}
end
