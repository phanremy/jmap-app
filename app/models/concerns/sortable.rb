# frozen_string_literal: true

module Sortable
  extend ActiveSupport::Concern

  included do
    def self.apply_sort(sort_params)
      return all if sort_params.blank?

      direction = :asc

      if sort_params.start_with?('-')
        sort_params = sort_params[1..]
        direction = :desc
      end

      scope = "order_by_#{sort_params}"

      return send(scope, direction) if respond_to?(scope)

      all
    end
  end
end
