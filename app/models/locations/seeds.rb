# frozen_string_literal: true

require 'csv'

module Locations
  class Seeds
    attr_reader :country

    def initialize(country:)
      @country = country.to_s.parameterize.underscore
    end

    def create_all
      Location.insert_all(
        CSV.read(file_name, headers: true)
           .map { |row| format_data(row) }
      )
    end

    private

    def format_data(row)
      data = row.to_h.except('id').merge

      type = if row['city'].present?
               'City'
             elsif row['county'].present?
               'County'
             else
               'Country'
             end

      data.merge(type:)
    end

    def file_name
      Rails.root.join('app', 'assets', 'locations', "#{country}.csv").to_s
    end
  end
end
