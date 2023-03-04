# frozen_string_literal: true

##
# items table stores Products of Sellers in this app
#
class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :client, null: false, foreign_key: true
      t.string :name
      t.string :kind, default: 'TEST'
      t.decimal :length, precision: 5, scale: 2
      t.decimal :width, precision: 5, scale: 2
      t.decimal :height, precision: 5, scale: 2
      t.string :distance_unit, default: 'cm'
      t.decimal :weight, precision: 5, scale: 2
      t.string :mass_unit, default: 'kg'

      t.timestamps
    end
  end
end
