# frozen_string_literal: true

class Country < Location
  validates :country, uniqueness: true

  has_many :counties,
           ->(location) { where country: location.country, type: 'County' },
           primary_key: :country,
           foreign_key: :country

  has_many :cities,
           ->(location) { where country: location.country, type: 'County' },
           primary_key: :country,
           foreign_key: :country
end
