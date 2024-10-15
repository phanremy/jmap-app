# frozen_string_literal: true

require 'active_model'

module Wizard
  class Base
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :stuff

    # validates_inclusion_of :link_url, in: Posts::Parse::URLS.keys
    # validate :method
    # validates attribute, presence: true
    # validates_inclusion_of :link_url, in: Posts::Parse::URLS.keys
    # validates_each :link_url do |record, attr, value|
    #   next if Posts::Parse::URLS.keys.any? { |key| value.start_with?(key.to_s) }

    #   record.errors.add attr, 'not recognized'
    # end

    def complete?
      raise NotImplementedError
    end

    def next_step
      raise NotImplementedError
    end

    def submit(params)
      params.each do |key, value|
        next unless params_attributes.include?(key)

        public_send("#{key}=", value)
      end

      perform if valid?
    end

    private

    def perform
      raise NotImplementedError
    end

    def params_attributes
      raise NotImplementedError
    end
  end
end
