# frozen_string_literal: true

class Location < ApplicationRecord
  include Sortable

  TYPES = %w[Country County City].freeze

  # enum type: Location::TYPES.to_enum
  validates :type, presence: true, inclusion: { in: Location::TYPES }

  after_initialize { self.type ||= self.class }

  scope :order_by_country, ->(direction = :asc) { order(country: direction) }
  scope :order_by_county, ->(direction = :asc) { order(county: direction) }
  scope :order_by_city, ->(direction = :asc) { order(city: direction) }
  scope :order_by_type, ->(direction = :asc) { order(type: direction) }
  scope :order_by_original_name, ->(direction = :asc) { order(original_name: direction) }
  scope :type_query, ->(type) { type.blank? ? return : where(type:) }
  scope :search_query, lambda { |search|
    return if search.blank?

    where(arel_table[:country].matches("%#{I18n.transliterate(search)}%"))
      .or(where(arel_table[:county].matches("%#{I18n.transliterate(search)}%")))
      .or(where(arel_table[:city].matches("%#{I18n.transliterate(search)}%")))
      .or(where(arel_table[:original_name].matches("%#{I18n.transliterate(search)}%")))
  }
end
