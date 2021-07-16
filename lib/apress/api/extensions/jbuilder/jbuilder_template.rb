# frozen_string_literal: true
module Apress
  module Api
    module Extensions
      module Jbuilder
        module JbuilderTemplate
          def paginating_cache!(collection, key = nil, options = nil)
            if @context.controller.perform_caching
              result = Rails.cache.fetch(_cache_key(key || collection, options), options) do
                {
                  headers: _pagination_headers(collection),
                  content: _scope { yield self }
                }
              end

              _set_pagination_headers(result[:headers])

              merge! result[:content]
            else
              _set_pagination_headers(_pagination_headers(collection))

              yield
            end
          end

          private

          def _set_pagination_headers(headers)
            @context.controller.response.headers.merge!(headers)
          end

          def _pagination_headers(collection)
            ::Apress::Api::ApiController::PaginationHelper.headers(
              collection,
              @context.controller.request.url
            )
          end
        end
      end
    end
  end
end
