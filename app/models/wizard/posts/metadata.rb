# frozen_string_literal: true

module Wizard
  module Posts
    class Metadata < Wizard::Base
      attribute :title, :string
      attribute :description, :string
      attribute :location_id, :string
      attribute :image_url, :string

      validate :location_id_uniqueness
      validates :title, :description, presence: true

      alias post stuff

      def perform
        post.update!(title:,
                     description:,
                     location_id: unique_location_id.first,
                     image_url:,
                     metadata_details: nil)
      end

      def complete?
        post.title.present? && post.description.present? && post.location_id.present? && post.image_url.present?
      end

      def next_step
        complete? ? nil : :metadata
      end

      def previous_step
        :link_url
      end

      private

      def params_attributes
        %w[title description location_id image_url]
      end

      def location_id_uniqueness
        return if unique_location_id.count == 1

        errors.add :location_id, "shall be present and unique"
      end

      def unique_location_id
        JSON.parse(location_id).reject(&:empty?)
      end
    end
  end
end
