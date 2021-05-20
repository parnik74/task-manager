class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    user.id == record.id
    # true
  end

  def destroy?
    user.id == record.id
    # true
  end
end
