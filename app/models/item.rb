# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :client

  validates_presence_of :name, :kind
end
