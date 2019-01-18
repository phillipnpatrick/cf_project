class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    can :read, :all #permit all users to read
    
    if user.present? # logged in users
      can :manage, User, id: user.id
      can [:create, :read], [Comment]
      
      if user.admin? # admin
        can :manage, :all
      end
    end
  end
end
