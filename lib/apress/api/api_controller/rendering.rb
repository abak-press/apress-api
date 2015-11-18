module Apress
  module Api
    module ApiController
      module Rendering
        def render_json(payload, status)
          payload.merge!(status: status) if request.xhr?
          render json: payload, status: request.xhr? ? 200 : status
        end
      end
    end
  end
end
