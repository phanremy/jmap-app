# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  FRONT_PATH = [
    { controller: 'pages', action: 'front' }
  ].freeze

  DARK_PATHS = FRONT_PATH

  def front_page?
    current_page_in?(FRONT_PATH)
  end

  def dark_theme?
    # request.referrer
    # request.url
    # request.path
    # request.env['PATH_INFO']
    # [front_path].map { |path| current_page?(path) }.any?
    current_page_in?(DARK_PATHS)
  end

  def date(datetime, format: :short)
    return if datetime.nil?

    l datetime.to_date, format:
  end

  private

  def current_page_in?(paths)
    paths.map { |p| params[:controller] == p[:controller] && params[:action] == p[:action] }.any?
  end
end
