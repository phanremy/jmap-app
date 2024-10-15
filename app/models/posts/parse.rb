# frozen_string_literal: true

module Posts
  class Parse
    attr_reader :link_url

    def initialize(link_url)
      @link_url = link_url
    end

    def metadata
      method = Post::ALLOWED_URLS.find { |www, _value| link_url.starts_with?(www.to_s) }.last

      return url_not_recognized_error unless method

      method_class = "Posts::Parses::#{method}".constantize

      method_class.new(link_url).metadata
    end

    def url_not_recognized_error
      { metadata_errors: 'URL not recognized' }
    end
  end
end
