# frozen_string_literal: true

class MetadataForm < BaseForm
  attribute :title, :string
  attribute :description, :string
  attribute :location_id, :string
  attribute :location_ids, :string
  attribute :image_url, :string

  # validates :mileage, numericality: { greater_than: 0 }

  validate :location_id_uniqueness

  def perform
    post.update!(title:, description:, location_id: unique_location_id.first, image_url:)
  end

  def complete?
    post.title.present? && post.description.present? && post.location_id.present? && post.image_url.present?
  end

  def next_step
    complete? ? nil : :metadata
  end

  def location_id_uniqueness
    return if unique_location_id.count == 1

    errors.add :location_id, "shall be present and unique"
  end

  def unique_location_id
    JSON.parse(location_id).reject { |c| c.empty? }
  end
end
