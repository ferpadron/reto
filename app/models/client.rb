# frozen_string_literal: true

##
# Model for clients table
# Created with:
# rails g model Client name kind zip country
#
class Client < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name, :kind

  FIELDS = columns.map(&:name).freeze

  ##
  # This method SEARCHES by field and value if given and SORTS as well as needed
  #
  def self.search(params = {})
    cond = FIELDS.include?(params[:f]) && params[:q].presence ? "lower(#{params[:f]}) LIKE '%#{params[:q]}%'" : nil
    data = where(cond)
    params[:order].presence ? data.order(params[:order]) : data
  end
end
