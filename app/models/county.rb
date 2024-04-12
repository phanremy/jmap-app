# frozen_string_literal: true

class County < Location
  belongs_to :country

  validates :country, :county, presence: true
  validates :county, uniqueness: { scope: %i[country], message: :uniqueness }
end
