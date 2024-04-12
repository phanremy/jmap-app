# frozen_string_literal: true

class City < Location
  belongs_to :country
  belongs_to :county, optional: true

  validates :country, :county, :city, presence: true
  validates :city, uniqueness: { scope: %i[country county], message: :uniqueness }
end
