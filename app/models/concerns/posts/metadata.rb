# frozen_string_literal: true

module Posts
  module Metadata
    extend ActiveSupport::Concern

    ALLOWED_URLS = {
      'https://www.instagram.com/p/': :Instagram,
      'https://www.tiktok.com/': :Tiktok
    }.freeze

    attr_accessor :metadata_errors, :location_ids

    def parse_metadata
      result = {}
      ::Posts::Parse.new(link_url).metadata.each do |key, value|
        result[key] = value
      end
      self.metadata_details = result
    end

    def inject_metadata
      metadata_details.each do |key, value|
        send("#{key}=", value)
      end
    end

    def parse_location
      Location.search_id_in([title, description].join(' '))
    end
  end
end
