# frozen_string_literal: true

require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  test 'client with a valid name and kind should be valid' do
    client = Client.new(name: 'Great Client', kind: 'NORMAL')
    client.save
    assert client.valid?
  end

  test 'client with a missing name should be invalid' do
    client = Client.new(name: nil, key: 'NORMAL')
    client.save
    assert_not client.valid?
  end

  test 'destroyed client should decrease the records number' do
    assert_difference('Client.count', 1) do
      Client.first.destroy
    end
  end
end
