# frozen_string_literal: true

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test 'item with a valid name and kind should be valid' do
    client = Client.first
    item = client.items.new(name: 'Great Item', kind: 'NORMAL')
    item.save
    assert item.valid?
  end

  test 'item with a missing name should be invalid' do
    item = Item.new(name: nil, kind: 'NORMAL', client_id: 1)
    item.save
    assert_not item.valid?
  end

  test 'destroyed item should decrease the records number' do
    assert_difference('Item.count', -1) do
      Item.first.destroy
    end
  end
end
