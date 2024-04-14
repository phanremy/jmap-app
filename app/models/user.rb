# frozen_string_literal: true

class User < ApplicationRecord
  include Sortable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :skip_password_validation # virtual attribute to skip password validation while saving

  has_many :spaces, class_name: 'Space', foreign_key: :owner_id
  has_many :links, class_name: 'Link', foreign_key: :owner_id, dependent: :destroy
  has_many :posts, dependent: :destroy

  scope :order_by_email, ->(direction = :asc) { order(email: direction) }
  scope :order_by_admin, ->(direction = :asc) { order(admin: direction) }
  scope :order_by_confirmed, ->(direction = :asc) { order(confirmed: direction) }

  scope :email_query, lambda { |email|
    email.blank? ? return : where(arel_table[:email].matches("%#{I18n.transliterate(email)}%"))
  }
  scope :admin_query, ->(admin) { admin.blank? ? return : where(admin:) }
  scope :confirmed_query, ->(confirmed) { confirmed.blank? ? return : where(confirmed:) }

  def self.default
    find_by(email: ENV.fetch('SUPERADMIN_EMAIL', nil))
  end

  def available_link(space)
    links.where(space:).where('end_date > ?', DateTime.now).first
  end

  protected

  def password_required?
    return false if skip_password_validation

    super
  end
end
