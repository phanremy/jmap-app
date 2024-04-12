# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :location
  belongs_to :space
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  validates :title, :body, presence: true, allow_blank: true
end
