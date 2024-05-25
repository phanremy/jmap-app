class CreateSpacePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :space_posts do |t|
      t.references :space, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
