# frozen_string_literal: true

class Post < ApplicationRecord
  include Posts::Metadata

  FREQUENCIES = %w[yearly].freeze

  belongs_to :location, optional: true
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  belongs_to :main, class_name: 'Post', foreign_key: :main_id, optional: true
  has_many :space_posts, dependent: :destroy
  has_many :spaces, through: :space_posts

  # before_create { self.creator = creator.presence || User.default }
  before_create { self.space_ids = space_ids.presence || [Space.default.id] }

  enum status: %i[incomplete pending available hidden].index_with(&:to_s).freeze
  validates :status, inclusion: { in: statuses.keys }
  validates :frequency, inclusion: { in: Post::FREQUENCIES, allow_blank: true }

  with_options if: :available? do
    validates :location_id, :title, :description, :image_url, :link_url, presence: true
    validates :starts_at, :ends_at, presence: true, if: :frequency?
    validates :latitude, :longitude, presence: true, if: :raw_address?
  end

  scope :location_query, lambda { |location_id|
    return if location_id.blank?

    where(location: Location.associated(location_id))
  }

  delegate :address, to: :location, allow_nil: true
end
