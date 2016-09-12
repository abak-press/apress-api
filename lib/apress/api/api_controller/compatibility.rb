module Apress
  module Api
    module ApiController
      module Compatibility
        def assets_dir=(*); end

        def javascripts_dir=(*); end

        def stylesheets_dir=(*); end

        def page_cache_directory=(*); end

        def relative_url_root=(*); end

        def helpers_path=(*); end

        def allow_forgery_protection=(*); end

        def helper(*); end

        def include_all_helpers=(*); end
        # :nocov:
      end
    end
  end
end
