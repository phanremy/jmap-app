# frozen_string_literal: true

module Posts
  module Query
    extend ActiveSupport::Concern

    def posts_query
      Post.accessible_by(current_ability)
          .complete
          .location_query(params[:location_id])
          .order(created_at: :desc)
    end
  end
end
