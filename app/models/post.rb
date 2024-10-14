# frozen_string_literal: true

class Post < ApplicationRecord
  FREQUENCIES = %w[yearly].freeze

  belongs_to :location, optional: true
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  belongs_to :main, class_name: 'Post', foreign_key: :main_id, optional: true
  has_many :space_posts, dependent: :destroy
  has_many :spaces, through: :space_posts

  before_validation { self.creator = creator.presence || User.default }
  before_validation { self.space_ids = space_ids.presence || [Space.default.id] }

  scope :incomplete, -> { where(location_id: nil).or(where(title: nil)) }
  scope :location_query, lambda { |location_id|
    return if location_id.blank?

    Post.where(location: Location.associated(location_id))
  }

  validates :frequency, inclusion: { in: Post::FREQUENCIES, allow_blank: true }

  delegate :address, to: :location, allow_nil: true

  # TODO: to put in a concern
  attr_accessor :metadata_errors, :location_ids

  def parse_metadata
    result = {}
    ::Posts::Parse.new(link_url).metadata.each do |key, value|
      result[key] = value
    end
    self.metadata_details = result
  end

  def inject_metadata
    metadata_details.each do |key, value|
      send("#{key}=", value)
    end
  end

  def parse_location
    Location.search_id_in([title, description].join(' '))
  end
end
