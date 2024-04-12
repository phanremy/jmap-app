# frozen_string_literal: true

class Country < Location
  validates :country, uniqueness: true
end
