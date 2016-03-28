module Apress
  module Api
    module ApiController
      module Pagination
        def pagination_headers(collection)
          headers["X-Total-Count"] = collection.total_entries.to_s
          headers["X-Total-Pages"] = collection.total_pages.to_s
        end
      end
    end
  end
end
