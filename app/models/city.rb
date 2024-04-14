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
end
