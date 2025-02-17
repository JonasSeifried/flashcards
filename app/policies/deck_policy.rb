class DeckPolicy < ApplicationPolicy
  def show?
    user.has_access_to_deck?(record)
  end

  def create?
    user.has_access_to_group?(record.group)
  end

  def update?
    user.has_access_to_deck?(record)
  end

  def destroy?
    user.has_access_to_deck?(record)
  end
  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
