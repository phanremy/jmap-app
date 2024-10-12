# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

module Posts
  module Parses
    class Instagram
      attr_reader :link_url

      def initialize(link_url)
        @link_url = link_url
      end

      # https://www.instagram.com/p/DA48CW4vReM/
      def metadata
        html = URI.parse(link_url).open.read
        doc = Nokogiri::HTML(html)

        title = doc.at('title')&.text
        image_url = doc.at("meta[property='og:image']")&.[]('content')
        description = doc.at("meta[name='description']")&.[]('content') ||
                      doc.at("meta[property='og:description']")&.[]('content')
        location = Location.first

        { title:, image_url:, description:, location: }
      end
    end
  end
end
