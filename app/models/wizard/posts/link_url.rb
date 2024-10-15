# frozen_string_literal: true

module Wizard
  module Posts
    class LinkUrl < Wizard::Base
      attribute :link_url, :string

      alias post stuff

      class RecognizedLinkUrlValidator < ActiveModel::Validator
        def validate(record)
          return if Post::ALLOWED_URLS.keys.any? { |key| record.link_url.start_with?(key.to_s) }

          record.errors.add :link_url, 'not recognized'
        end
      end

      validates_with RecognizedLinkUrlValidator

      def perform
        post.link_url = link_url
        post.parse_metadata
        post.save
      end

      def complete?
        post.link_url.present? && post.metadata_details.present?
      end

      def next_step
        complete? ? :metadata : :link_url
      end

      private

      def params_attributes
        %w[link_url]
      end
    end
  end
end
