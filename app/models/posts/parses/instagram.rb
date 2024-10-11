# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

module Posts
  module Parses
    class Instagram
      attr_reader :url

      def initialize(url)
        @url = url
      end

      def metadata
        html = URI.open(url).read
        doc = Nokogiri::HTML(html)

        title = doc.at('title')&.text
        image = doc.at("meta[property='og:image']")&.[]('content')
        description = doc.at("meta[name='description']")&.[]('content') ||
          doc.at("meta[property='og:description']")&.[]('content')

          {
            title: title,
            description: description,
            image: image
          }
      end
    end
  end
end
