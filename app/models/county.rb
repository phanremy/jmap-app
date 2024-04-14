# frozen_string_literal: true

class County < Location
  has_many :countries,
           ->(location) { where country: location.country, type: 'Country' },
           primary_key: :country,
           foreign_key: :country

  validates :country, :county, presence: true
  validates :county, uniqueness: { scope: %i[country], message: :uniqueness }
  validate :city_attribute_nil

  def associated_country
    countries.first
  end

  private

  def city_attribute_nil
    errors.add(:city, "must be nil") if city.present?
  end
end
