# frozen_string_literal: true

class Location < ApplicationRecord
  include Sortable

  TYPES = %w[Country County City].freeze

  # enum type: Location::TYPES.to_enum
  validates :type, presence: true, inclusion: { in: Location::TYPES }

  after_initialize { self.type ||= self.class }
  before_validation { self.original_name = original_name || city || county || city }
  before_validation { self.country = country ? I18n.transliterate(country) : nil }
  before_validation { self.county = county ? I18n.transliterate(county) : nil }
  before_validation { self.city = city ? I18n.transliterate(city) : nil }

  scope :order_by_country, ->(direction = :asc) { order(country: direction) }
  scope :order_by_county, ->(direction = :asc) { order(county: direction) }
  scope :order_by_city, ->(direction = :asc) { order(city: direction) }
  scope :order_by_type, ->(direction = :asc) { order(type: direction) }
  scope :order_by_original_name, ->(direction = :asc) { order(original_name: direction) }
  scope :type_query, ->(type) { type.blank? ? return : where(type:) }
  scope :with_geolocation, -> { where.not(longitude: nil).where.not(latitude: nil) }
  scope :search_query, lambda { |query|
    return if query.blank?

    where('locations.country ILIKE :query OR
           locations.county ILIKE :query OR
           locations.city ILIKE :query OR
           locations.original_name ILIKE :query', query: "%#{I18n.transliterate(query)}%")
  }

  def address
    # type_info = type == 'City' ? " - #{county}" : "" (#{type})""
    type_info = type == 'City' ? " - #{county}" : ""
    # [send(type.downcase), type_info].join
    [original_name, " (#{send(type.downcase)}#{type_info})"].join
  end

  def self.associated(id)
    country, county, city = where(id:).pick(:country, :county, :city)

    where(type: 'Country', country:)
      .or(where(type: 'County', country:, county:))
      .or(where(type: 'City', country:, county:, city:))
  end

  def self.default
    first
  end

  def self.search_id_in(text)
    text = text.gsub("\n", '')
    query = ActiveRecord::Base.sanitize_sql(
      [File.read("app/queries/locations/search_id_in.sql"),
       { text: }]
    )

    ActiveRecord::Base.connection.select_all(query).entries.map { |data| data['id'] }
  end
end
