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
      end

      test 'should not get index because error on purpose' do
        get api_v1_fedex_quotes_url(item_no: 10), as: :json
        assert_response :bad_request
      end
    end
  end
end
