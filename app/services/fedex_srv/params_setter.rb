# frozen_string_literal: true

module FedexSrv
  ##
  # Simple setter of correct params to get Fedex quotes
  #
  class ParamsSetter < ApplicationService

    def initialize(params)
      @client = Client.where(id: params[:client_id]).first
      @item = @client&.items&.where(id: params[:item_id]).first
      @zip = params[:zip]
      @country = params[:country]
    end

    def call
      raise 'Client not found' unless @client
      raise 'Item not found' unless @item
      {
        address_from: {
          zip: @client.zip,
          country: @client.country
        },
        address_to: {
          zip: @zip,
          country: @country
        },
        parcel: {
          length: @item.length,
          width: @item.width,
          height: @item.height,
          distance_unit: @item.distance_unit,
          weight: @item.weight,
          mass_unit: @item.mass_unit
        }
      }
    end
  end
end
