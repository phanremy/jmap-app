# frozen_string_literal: true

class Space < ApplicationRecord
  # TODO: counter_cache: true ?
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  validates :description, presence: true, uniqueness: { scope: :owner_id }
  has_many :space_users, dependent: :destroy
  has_many :space_posts, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :users, through: :space_users
  has_many :links, dependent: :destroy

  def self.default
    where(public: true).first
  end

  def members
    users.including(owner)
  end

  def confirmed_member?(user)
    user.confirmed? && members.include?(user)
  end

  def unconfirmed_member?(user)
    !user.confirmed? && members.include?(user)
  end
end
