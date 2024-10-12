# frozen_string_literal: true

class Post < ApplicationRecord
  FREQUENCIES = %w[yearly].freeze

  belongs_to :location
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  belongs_to :main, class_name: 'Post', foreign_key: :main_id, optional: true
  has_many :space_posts, dependent: :destroy
  has_many :spaces, through: :space_posts

  before_validation { self.space_ids = space_ids.presence || [Space.default.id] }
  before_validation { self.creator = creator.presence || User.default }

  scope :location_query, lambda { |location_id|
    return if location_id.blank?

    Post.where(location: Location.associated(location_id))
  }

  validates :title, presence: true
  validates :frequency, inclusion: { in: Post::FREQUENCIES, allow_blank: true }

  delegate :address, to: :location

  # TODO: to put in a concern
  attr_accessor :metadata_errors

  def parse_metadata
    ::Posts::Parse.new(link_url).metadata.each do |key, value|
      send("#{key}=", value)
    end
  end
end
