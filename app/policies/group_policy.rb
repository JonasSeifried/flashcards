class GroupPolicy < ApplicationPolicy
  def show?
    user.has_access_to_group?(record)
  end

  def update?
    user.has_access_to_group?(record)
  end

  def destroy?
    user.has_access_to_group?(record)
  end


  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
