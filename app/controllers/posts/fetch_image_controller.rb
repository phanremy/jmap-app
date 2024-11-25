# frozen_string_literal: true

module Posts
  class FetchImageController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[show]

    def show
      @post_id = params[:post_id]
      @image_url = current_user.nil? ? params[:image_url] : fetch_image
    end

    private

    def fetch_image
      html = URI.parse(params[:image_url]).open.read
      doc = Nokogiri::HTML(html)

      params[:image_url]
    rescue StandardError
      can?(:create, Post) ? update_image_url : 'https://picsum.photos/200/200?random=1'
    end

    def update_image_url
      post = Post.find(params[:post_id])
      image_url = post.parse_metadata[:image_url]
      post.reload.update(image_url:)
      image_url
    end
  end
end
