# frozen_string_literal: true

module Posts
  class Parse
    attr_reader :link_url

    URLS = {
      'https://www.instagram.com/p/': :Instagram,
      'https://www.tiktok.com/': :Tiktok
    }.freeze

    def initialize(link_url)
      @link_url = link_url
    end

    def metadata
      return 'URL not recognized' unless URLS.keys.any? { |www| link_url.starts_with?(www.to_s) }

      method = URLS.find { |www, _value| link_url.starts_with?(www.to_s) }.last

      method_class = "Posts::Parses::#{method}".constantize

      method_class.new(link_url).metadata
    end
  end
end
