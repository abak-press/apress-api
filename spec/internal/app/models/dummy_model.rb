class DummyModel < ActiveRecord::Base
  include Apress::Api::Callbacks::Integration

  notify_services event: 'some_event',
                  params: [:name],
                  at: [:after_save, if: :name_empty?]

  notify_services event: 'dynamic_params_event',
                  params: ->(model) { {name: model.name + " stuff"} },
                  at: [:before_update]

  def name_empty?
    name.blank?
  end
end
