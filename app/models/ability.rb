# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :wizard
    can :read, Location
    can :read, Post
    can :read, Link

    return unless user&.confirmed?

    admin_abilities if user&.admin? || user.email == ENV.fetch('SUPERADMIN_EMAIL', nil)
    user_abilities(user) if user
  end

  def admin_abilities
    can :manage, Post
    can :manage, Space
    can :manage, User
    can :manage, Link
  end

  def user_abilities(user)
    can :manage, Space, owner: user
    # can :manage, Space, users: { id: user.id }
    can :read, Space, users: { id: user.id }
    can %i[create destroy], Link, space: { owner: user }
  end
end
