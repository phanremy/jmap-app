# frozen_string_literal: true

class CreatePostStatus < ActiveRecord::Migration[7.1]
  def up
    create_enum :post_status, %i[incomplete pending available hidden]
    add_column :posts, :status, :post_status, default: :incomplete, null: false
    add_index :posts, :status
  end

  def down
    drop_enum :post_status
  end
end
