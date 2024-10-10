# frozen_string_literal: true

class Post < ApplicationRecord
  FREQUENCIES = %w[yearly].freeze

  belongs_to :location
  has_many :space_posts, dependent: :destroy
  has_many :spaces, through: :space_posts
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  belongs_to :main, class_name: 'Post', foreign_key: :main_id, optional: true

  # before_validation { self.space ||= Space.default }
  before_validation { self.creator ||= User.default }

  scope :location_query, lambda { |location_id|
    return if location_id.blank?

    location = Location.find(location_id)

    where(
      location: Location.where(
        country:                     location.country,
        "#{location.type.downcase}": location.send(location.type.downcase)
      )
    )
  }

  validates :title, :content, presence: true, allow_blank: true
  validates :frequency, inclusion: { in: Post::FREQUENCIES, allow_blank: true }

  delegate :address, to: :location
end
