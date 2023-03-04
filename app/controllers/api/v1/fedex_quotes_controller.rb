# frozen_string_literal: true

require 'fedex'

module Api
  module V1
    ##
    # Main controller in this API
    #
    # Basic URL
    # http://localhost:3000/api/v1/fedex_quotes OR http://localhost:3000
    #
    # Allowed parameters:
    # client_id, item_id, zip (address_to), country (address_to)
    # if any parameter is not provided, the values from the documentation will be taken ('normalize_params' method)
    #
    class FedexQuotesController < ApplicationController
      before_action :normalize_params, only: %i[index]

      def index
        quote_params = FedexSrv::ParamsSetter.call(params)
        credentials = { key: 'bkjIgUhxdghtLw9L', password: '6p8oOccHmDwuJZCyJs44wQ0Iw' }
        rates = Fedex::Rates.get(credentials, quote_params)

        render json: rates, status: :ok
      rescue StandardError => e
        render json: { message: "Error: #{e.message}" }, status: :bad_request
      end

      private

      def normalize_params
        params[:client_id] = params[:client_id].present? ? params[:client_id].to_i : 1
        params[:item_id] = params[:item_id].present? ? params[:item_id].to_i : 1
        params[:zip] = '06500' if params[:zip].blank?
        params[:country] = 'MX' if params[:country].blank?
      end
    end
  end
end
