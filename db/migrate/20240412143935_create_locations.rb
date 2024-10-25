# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :type, null: false
      t.string :country, null: false
      t.string :county
      t.string :city
      t.string :original_name
      t.decimal :longitude
      t.decimal :latitude
    end

    add_index :locations, %i[country], unique: true, where: "((county IS NULL) AND (city IS NULL))"
    add_index :locations, %i[country county], unique: true, where: "(city IS NULL)"
    add_index :locations, %i[country county city], unique: true
  end
end
