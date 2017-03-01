module Apress
  module Api
    module ApiController
      class CompanyBase < Apress::Api::ApiController::Base
        abstract!

        include Apress::Companies::Extensions::Controllers::CompanyContext
        include Pundit

        before_filter :set_company_and_context
        before_filter :lock_if_in_readonly_mode

        ActiveSupport.run_load_hooks(:'apress/api/api_controller/company_base', self)
      end
    end
  end
end
