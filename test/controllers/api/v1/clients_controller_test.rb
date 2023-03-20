# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class ClientsControllerTest < ActionDispatch::IntegrationTest
      setup do
        puts "Clients controller: #{ActiveSupport::Inflector.humanize(method_name)} -> OK!"
      end

      teardown do
        Rails.cache.clear
      end

      test 'should get index' do
        get api_v1_clients_url
        assert_response :success
      end

      test 'hash_extending_should_get_100%_in_test_coverage' do
        tmp = { password: 'must-disappear' }.except_nested(:password)
        assert_equal(tmp, {})
        tmp = { credentials: { password: 'must-disappear' } }.except_nested(:password)
        assert_equal(tmp, { credentials: {} })
        tmp = { jwt: { credentials: { password: 'must-disappear' } } }.except_nested(:password)
        assert_equal(tmp, { jwt: { credentials: {} } })
      end
    end
  end
end
