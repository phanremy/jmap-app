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
    # [root_path].map { |path| current_page?(path) }.any?
    # true
    current_page_in?(DARK_PATHS)
  end

  def date(datetime, format: :short)
    return if datetime.nil?

    l datetime.to_date, format:
  end

  def create_google_calendar_link(title, starting_date, ending_date, body, address)
    "http://www.google.com/calendar/event?action=TEMPLATE" \
      "#{"&text=#{CGI.escape(title)}" if title}" \
      "&dates=#{CGI.escape((starting_date.to_datetime - 1.hour).strftime('%Y%m%dT%H%M%S'))}/" \
      "#{CGI.escape((ending_date.to_datetime - 1.hour).strftime('%Y%m%dT%H%M%S'))}" \
      "&ctz=#{Rails.application.config.time_zone}" \
      "#{"&details=#{CGI.escape(body)}" if body}" \
      "#{"&location=#{CGI.escape(address)}" if address}"
  end

  private

  def current_page_in?(paths)
    paths.map { |p| params[:controller] == p[:controller] && params[:action] == p[:action] }.any?
  end
end
