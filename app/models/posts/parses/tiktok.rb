# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

module Posts
  module Parses
    class Tiktok
      attr_reader :link_url

      def initialize(link_url)
        @link_url = link_url
      end

      # https://www.tiktok.com/@rhillio62/video/7414634946368703777
      def metadata
        'tiktok not working'
        # html = URI.open(link_url).read
        # doc = Nokogiri::HTML(html)

        # title = doc.at('title')&.text
        # image = doc.at("meta[property='og:image']")&.[]('content')
        # description = doc.at("meta[name='description']")&.[]('content') ||
        #   doc.at("meta[property='og:description']")&.[]('content')

        #   {
        #     title: title,
        #     description: description,
        #     image: image
        #   }
      end
    end
  end
end
