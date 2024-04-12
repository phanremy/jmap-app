# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :url
      t.string :title
      t.text :content
      t.references :location, null: true
      t.references :space, null: false, foreign_key: true
      t.references :creator, index: true, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    # index on location
  end
end
