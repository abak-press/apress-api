module Apress
  module Api
    module ApiController
      module Pagination
        # Public
        #  set pagination headers - X-Total-Count, X-Total-Pages
        #
        # Arguments:
        #   collection:
        #     type: Any, MUST respond to `total_pages` and `total_entries`, MAY respond to cache_key
        #     requre: true
        #     description: Some collection or data with pagination
        #   cache_options:
        #     type: Hash
        #     require: false
        #     description: cache options, mainly - cache_tags or/and expire_in
        #
        # Examples:
        #
        #   with caching
        #
        #   def index
        #     @colection = OrderFinder.new(some_args) # responds to cache_key
        #     pagination_headers(@collection, cache_tags: {user_id => user.id}, expire_in: 30.minutes)
        #   end
        #
        #   def index
        #     @collection = Order.where(ids: ids).paginate(paginate_options)
        #     pagination_headers(@collection, cache_key: cache_key, expire_in: 30.minutes)
        #   end
        #
        #   without cache
        #
        #   def index
        #     @collection = Order.where(ids: ids).paginate(paginate_options)
        #     pagination_headers(@collection)
        #   end
        #
        #
        def pagination_headers(collection, cache_options = {})
          headers["X-Total-Count"] = total_entries(collection, cache_options).to_s
          headers["X-Total-Pages"] = total_pages(collection, cache_options).to_s
        end

        def total_pages(collection, cache_options)
          cache(collection, 'total_pages', cache_options) { collection.total_pages }
        end

        def total_entries(collection, cache_options)
          cache(collection, 'total_entries', cache_options) { collection.total_entries }
        end

        def cache(collection, key_suffix, cache_options)
          if cache_options.present?
            key_prefix = cache_options[:cache_key] || collection.cache_key
            Rails.cache.fetch("#{key_prefix}/#{key_suffix}", cache_options) do
              yield
            end
          else
            yield
          end
        end
      end
    end
  end
end
