# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :type, null: false
      t.string :country, null: false
      t.string :county
      t.string :city
      t.decimal :longitude
      t.decimal :latitude
    end
  end
end
