class LocationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  skip_authorization_check

  def index
    params[:sort] ||= 'city'

    @pagy, @locations = pagy locations_query
    @search_params = %i[type country county city]
  end

  private

  def locations_query
    Location.accessible_by(current_ability)
            .search_query(params[:search])
            .type_query(params[:type])
            .apply_sort(params[:sort])
  end
end
