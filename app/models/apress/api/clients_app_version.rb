module Apress
  module Api
    class ClientsAppVersion < ActiveYaml::Base
      set_root_path Rails.root.join('config')
      set_filename('clients_app_version')
    end
  end
end
