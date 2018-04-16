Apress::Api::Callbacks::Config.add_client('service_access_id')

Apress::Api::Callbacks::Config.add_service(service: 'service', event: 'some_event')
Apress::Api::Callbacks::Config.add_service(service: 'error', event: 'some_error_event')
Apress::Api::Callbacks::Config.add_service(service: 'error', event: 'repeat_error')
Apress::Api::Callbacks::Config.add_service(service: 'service', event: 'dynamic_params_event')
Apress::Api::Callbacks::Config.add_handler(service: 'external_service', event: 'other_event', handler: 'handler_job')
