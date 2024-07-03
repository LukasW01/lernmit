class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      cannot %i[create update destroy], Task
      cannot %i[create update destroy], Learnset
    end
  end
end
