# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :link_url
      # t.jsonb :metadata_details, null: false
      t.string :image_url
      t.string :title
      t.text :description
      # t.references :space, null: false, foreign_key: true
      t.references :location, null: true
      t.references :main, index: true, foreign_key: { to_table: :posts }
      t.references :creator, index: true, null: false, foreign_key: { to_table: :users }
      # t.jsonb :frequence_details, null: false
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :frequency
      # t.jsonb :location_details, null: false
      t.string :raw_address
      t.decimal :longitude
      t.decimal :latitude

      t.timestamps
    end
  end
end
