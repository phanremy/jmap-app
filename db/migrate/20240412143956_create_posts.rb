# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :link_url, default: '', null: false
      t.string :image_url, default: '', null: false
      t.string :title, default: '', null: false
      t.text :description, default: '', null: false
      t.jsonb :metadata_details, default: {}, null: false
      t.references :location, null: true
      t.references :main, index: true, foreign_key: { to_table: :posts }
      t.references :creator, index: true, null: false, foreign_key: { to_table: :users }
      # t.jsonb :frequence_details, default: {}
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :frequency
      # t.jsonb :location_details, default: {}
      t.string :raw_address
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
