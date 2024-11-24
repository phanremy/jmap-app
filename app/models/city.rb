# frozen_string_literal: true

class City < Location
  has_many :countries,
           ->(location) { where country: location.country, type: 'Country' },
           primary_key: :country,
           foreign_key: :country

  has_many :counties,
           ->(location) { where country: location.country, county: location.county, type: 'County' },
           primary_key: :county,
           foreign_key: :county

  def associated_country
    countries.first
  end

  def associated_county
    counties.first
  end

  validates :country, :city, presence: true
  validates :city, uniqueness: { scope: %i[country county], message: :uniqueness }

  def self.markers(posts_query)
    with_geolocation
      .where(id: posts_query.uniq.pluck(:location_id))
      .pluck(:id, :city, :longitude, :latitude)
      .map { |data| { id: data[0], name: data[1], coordinates: [data[2], data[3]] } }
  end
end
