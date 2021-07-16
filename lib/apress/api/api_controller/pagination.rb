# frozen_string_literal: true
require 'addressable/uri'
require 'apress/api/api_controller/pagination_helper'
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

          headers.merge!(::Apress::Api::ApiController::PaginationHelper.headers(collection, request.url))
        end
      end
    end
  end
end
