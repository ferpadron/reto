# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name, :kind
end
