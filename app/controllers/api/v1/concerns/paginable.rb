# frozen_string_literal: true

module Api
  module V1
    module Concerns
      ##
      # This code is to add links of pagination in frontend
      # Per page is set to 4 (default) for demo purposes
      # get_links_serializer_options, current_page, per_page are in a concern because they work identically for any
      # controller/serializer.
      #
      module Paginable
        protected

        def get_links_serializer_options(links_paths, collection)
          {
            links: {
              first: send(links_paths, page: 1),
              prev: send(links_paths, page: collection.prev_page),
              next: send(links_paths, page: collection.next_page),
              last: send(links_paths, page: collection.total_pages)
            }
          }
        end

        def current_page
          (params[:page] || 1).to_i
        end

        def per_page
          (params[:per_page] || 4).to_i
        end
      end
    end
  end
end

