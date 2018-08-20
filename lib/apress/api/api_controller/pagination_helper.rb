module Apress
  module Api
    module ApiController
      module PaginationHelper
        def self.headers(collection, url)
          result = {}

          result['X-Total-Count'] = collection.total_entries.to_s
          result['X-Total-Pages'] = collection.total_pages.to_s
          result['X-Per-Page'] = collection.per_page.to_s
          result['X-Page'] = collection.current_page.to_s

          numbers = page_numbers(collection)
          links = header_link_values(url, numbers)

          result['Link'] = links.join(', ') if links.present?

          result
        end

        def self.header_link_values(url, page_numbers)
          url = ::Addressable::URI.parse(url)
          url.query_values ||= {}

          page_numbers.map do |rel, number|
            url.query_values = url.query_values.merge('page' => number)

            %(<#{url}>; rel="#{rel}")
          end
        rescue ::Addressable::URI::InvalidURIError
          []
        end

        def self.page_numbers(collection)
          result = {}
          return result unless collection.total_pages > 1

          if collection.current_page > 1
            result[:first] = 1
            result[:prev] = collection.current_page - 1
          end

          if collection.current_page < collection.total_pages
            result[:last] = collection.total_pages
            result[:next] = collection.current_page + 1
          end

          result
        end

        private_class_method :header_link_values, :page_numbers
      end
    end
  end
end
