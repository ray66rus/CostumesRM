class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :read, Costume
    elsif user.admin?
      can :manage, :all
      can :change_user_type, User
      can :view_users_list, User
    else
      if user.user?
        can :read, Client
        can :read, Costume
        can [:read, :create], Order
        can [:update, :destroy], Order, :user_id => user.id
        can :read, Part
      elsif user.power_user?
        can :manage, :all
      end
      cannot :manage, User
      can [:read, :update], User, :id => user.id
    end
  end
end
