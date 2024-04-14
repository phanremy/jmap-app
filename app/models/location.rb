# frozen_string_literal: true

class Location < ApplicationRecord
  TYPES = %w[Country County City].freeze

  # enum type: Location::TYPES.to_enum
  validates :type, presence: true, inclusion: { in: Location::TYPES }

  after_initialize { self.type ||= self.class }
end
