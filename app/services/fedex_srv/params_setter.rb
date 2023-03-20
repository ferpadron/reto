# frozen_string_literal: true

module FedexSrv
  ##
  # Simple setter of correct params to get Fedex quotes
  #
  class ParamsSetter < ApplicationService

    def initialize(params)
      @client = Client.where(id: params[:client_id].present? ? params[:client_id].to_i : 1).first
      @item = @client&.items[params[:item_no].presence ? params[:item_no].to_i - 1 : 0]
      @address_to = { zip: params[:zip] || '06500', country: params[:country] || 'MX' }
    end

    def call
      raise 'Client not found' unless @client
      raise 'Item not found' unless @item

      {
        address_from: { zip: @client.zip, country: @client.country },
        address_to: @address_to,
        parcel: { length: @item.length, width: @item.width, height: @item.height, distance_unit: @item.distance_unit,
                  weight: @item.weight, mass_unit: @item.mass_unit }
      }
    end
  end
end
