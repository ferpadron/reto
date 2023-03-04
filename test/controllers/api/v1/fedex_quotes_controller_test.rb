# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class FedexQuotesControllerTest < ActionDispatch::IntegrationTest
      setup do
        puts "Fedex Quotes controller: #{ActiveSupport::Inflector.humanize(method_name)} -> OK!"
      end

      teardown do
        Rails.cache.clear
      end

      test 'should get index' do
        get api_v1_fedex_quotes_url, as: :json
        assert_response :success

        json_response = JSON.parse(response.body, symbolize_names: true)
        assert_equal 'MXN', json_response.first[:currency]
      end
    end
  end
end
