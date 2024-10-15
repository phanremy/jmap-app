# frozen_string_literal: true

require 'active_model'

class BaseForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :post

  def complete?
    raise NotImplementedError
  end

  def next_step
    raise NotImplementedError
  end

  def submit(params)
    params.each do |key, value|
      next unless params_attribute?(key)

      public_send("#{key}=", value)
    end

    perform if valid?
  end

  private

  def perform
    raise NotImplementedError
  end

  def params_attribute?(key)
    (attribute_names - ['post']).include?(key)
  end
end
