class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?
    if user.admin?
      can :manage, :all
      can :change_user_type, User
    else
      can :manage, :all
      cannot :manage, User
      can [:read, :update], User, :id => user.id
    end
  end
end
