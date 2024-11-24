# frozen_string_literal: true

class PagesController < ApplicationController
  include Posts::Query

  # authorize_resource class: false
  skip_before_action :authenticate_user!
  skip_authorization_check

  def front; end

  def map
    @cities_markers =
      City.with_geolocation
          .where(id: posts_query.uniq.pluck(:location_id))
          .pluck(:id, :city, :longitude, :latitude)
          .map { |data| { id: data[0], name: data[1], coordinates: [data[2], data[3]] } }
  end

  def moon
    cookies[:moon] = { value: 'on' }
    redirect_to request.referrer || root_url
  end

  def sun
    cookies.delete(:moon)
    redirect_to request.referrer || root_url
  end

  def open_modal
    render turbo_stream: turbo_stream.append(
      :modal,
      partial: 'shared/modal',
      locals: { content: params[:content] }
    )
  end
end
