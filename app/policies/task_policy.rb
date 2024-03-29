class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.all
      scope.where(assignee_id: user.id)
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    user.id == record.assignee_id
    # true
  end

  def destroy?
    user.id == record.assignee_id
    # true
  end
end
