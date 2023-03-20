# frozen_string_literal: true

##
# My private gem is 'fedex'
#
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
    # client_id, item_no, zip (address_to), country (address_to)
    # if any parameter is not provided, the values from the documentation will be taken
    #
    # FedexSrv::ParamsSetter (app/services/fedex_srv/params_setter.rb) is a
    #   Design Pattern => Behavioral pattern => Command called in Ruby on Rails 'service objects' (very nice)
    #
    # Fedex:Rates.get is the behavior into my gem 'fedex' at https://github.com/ferpadron/fedex
    #
    class FedexQuotesController < ApplicationController
      def index
        render json: Fedex::Rates.get(CREDENTIALS, FedexSrv::ParamsSetter.call(params)), status: :ok
      rescue StandardError => e
        render json: { message: "Error: #{e.message}" }, status: :bad_request
      end
    end
  end
end
