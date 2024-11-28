# frozen_string_literal: true

module Posts
  module Query
    extend ActiveSupport::Concern

    def posts_query
      Post.accessible_by(current_ability)
          .from_confirmed_users
          .location_query(params[:location_id])
          .available
          .order(created_at: :desc)
    end
  end
end
