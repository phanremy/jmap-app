# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :type, null: false
      t.string :country, null: false
      t.string :county
      t.string :city
      t.string :original_name
    end

    add_index :locations, %i[country county city], unique: true
  end
end
