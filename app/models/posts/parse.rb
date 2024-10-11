# frozen_string_literal: true

module Posts
  class Parse
    attr_reader :url

    URLS = {
      'https://www.instagram.com/p/': :Instagram,
      'https://www.tiktok.com/': :Tiktok
    }.freeze

    def initialize(url)
      @url = url
    end

    def metadata
      return 'URL not recognized' unless URLS.keys.any? { |www| url.starts_with?(www.to_s) }

      method = URLS.find { |www, value| url.starts_with?(www.to_s) }.last

      method_class = "Posts::Parses::#{method}".constantize

      method_class.new(url).metadata
    end
  end
end
