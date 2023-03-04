# frozen_string_literal: true

##
# clients table stores Sellers of this app
#
class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :kind, default: 'TEST'
      t.string :zip, default: '64000'
      t.string :country, default: 'MX'

      t.timestamps
    end
  end
end
