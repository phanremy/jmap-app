# frozen_string_literal: true

class UrlForm < BaseForm
  attribute :link_url, :string

  class RecognizedLinkUrlValidator < ActiveModel::Validator
    def validate(record)
      return if Posts::Parse::URLS.keys.any? { |key| record.link_url.start_with?(key.to_s) }

      record.errors.add :link_url, 'not recognized'
    end
  end

  # validates_inclusion_of :link_url, in: Posts::Parse::URLS.keys
  # validate :method
  validates_with RecognizedLinkUrlValidator
  # validates_inclusion_of :link_url, in: Posts::Parse::URLS.keys
  # validates_each :link_url do |record, attr, value|
  #   next if Posts::Parse::URLS.keys.any? { |key| value.start_with?(key.to_s) }

  #   record.errors.add attr, 'not recognized'
  # end

  def perform
    post.link_url = link_url
    post.parse_metadata
    post.save
  end

  def complete?
    post.link_url.present? && post.metadata_details.present?
  end

  def next_step
    complete? ? :metadata : :url
  end
end
