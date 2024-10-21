# frozen_string_literal: true

class Post < ApplicationRecord
  include Posts::Metadata

  FREQUENCIES = %w[yearly].freeze

  belongs_to :location, optional: true
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  belongs_to :main, class_name: 'Post', foreign_key: :main_id, optional: true
  has_many :space_posts, dependent: :destroy
  has_many :spaces, through: :space_posts

  before_validation { self.creator = creator.presence || User.default }
  before_validation { self.space_ids = space_ids.presence || [Space.default.id] }

  scope :complete, -> { where.not(location_id: nil) }
  scope :incomplete, -> { !complete }
  scope :location_query, lambda { |location_id|
    return if location_id.blank?

    where(location: Location.associated(location_id))
  }

  validates :frequency, inclusion: { in: Post::FREQUENCIES, allow_blank: true }

  delegate :address, to: :location, allow_nil: true
end
