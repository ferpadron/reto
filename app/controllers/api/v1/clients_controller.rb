# frozen_string_literal: true

module Api
  module V1
    ##
    # This class is a personal behavior to show my skills handling the JSON:API module
    #
    class ClientsController < ApplicationController
      include Api::V1::Concerns::Paginable

      def index
        @clients = Client.search(params).page(current_page).per(per_page)
        render json: ClientSerializer.new(@clients, opts).serializable_hash, status: :ok
      end

      private

      ##
      # Simple sample of the potential of JSON:API serializer gem
      #
      def opts
        last = Time.now.strftime('%Y-%m-%d %H:%M:%S') # display data on the fly
        {
          include: [:items], # How to handle associations
          meta: { last_time: last, records_no: @clients.length }, # Some samples of additional data
          links: get_links_serializer_options('api_v1_clients_path', @clients) # Useful in large responses
        }
      end
    end
  end
end
