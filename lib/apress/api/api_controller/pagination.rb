require 'addressable/uri'
module Apress
  module Api
    module ApiController
      module Pagination
        class InvalidPaginationError < StandardError; end
        class LinkHeaderAppendNotImplemented < StandardError; end

        extend ActiveSupport::Concern

        included do
          attr_reader :per_page, :page
          alias_method :current_page, :page
          rescue_from InvalidPaginationError, with: :bad_request
        end

        DEFAULT_PER_PAGE = 30
        MAX_PER_PAGE = 100

        # Public: sets page and per_page variables
        #
        # options - Hash, configuration
        #           :per_page - Hash, per_page value configuration
        #                       :max - Integer, max per_page value
        #                       :defuault - Integer, default value for per_page
        # Examples
        #   prepare_pagination(per_page: {max: 110, default: 40})
        #
        #   or with defaults max - 100 and default - 30
        #
        #   prepare_pagination
        #
        # Returns nothing
        def prepare_pagination(options = {})
          per_page = options.fetch(:per_page, {})
          max_per_page = per_page.fetch(:max, MAX_PER_PAGE)
          default_per_page = per_page.fetch(:default, DEFAULT_PER_PAGE)

          @page = params.fetch(:page, 1).to_i
          raise InvalidPaginationError if @page <= 0

          @per_page = params.fetch(:per_page, default_per_page).to_i
          raise InvalidPaginationError unless (1..max_per_page).include?(@per_page)
        end

        # Public: sets pagination headers
        #
        # collection - WillPaginate::Collection
        #
        # Returns nothing
        def pagination_headers(collection)
          raise LinkHeaderAppendNotImplemented if headers['Link'].present?

          headers.merge!(PaginationHelper.headers(collection, request.url))
        end
      end

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
