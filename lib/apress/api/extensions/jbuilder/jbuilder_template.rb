module Apress
  module Api
    module Extensions
      module Jbuilder
        module JbuilderTemplate
          def paginating_cache!(collection, key = nil, options = nil)
            if @context.controller.perform_caching
              result = Rails.cache.fetch(_cache_key(key || collection, options), options) do
                {
                  total_entries: collection.total_entries,
                  total_pages: collection.total_pages,
                  content: _scope { yield self }
                }
              end

              _set_pagination_headers(result[:total_entries], result[:total_pages])

              merge! result[:content]
            else
              _set_pagination_headers(collection.total_entries, collection.total_pages)

              yield
            end
          end

          private

          def _set_pagination_headers(total_entries, total_pages)
            @context.controller.response.headers["X-Total-Count"] = total_entries.to_s
            @context.controller.response.headers["X-Total-Pages"] = total_pages.to_s
          end
        end
      end
    end
  end
end
