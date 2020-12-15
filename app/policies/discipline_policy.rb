class DisciplinePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.select(&:active)
    end
  end

  def create?
    user.admin? || user.professor?
  end
  def new?
    user.admin? || user.professor?
  end

  def edit?
    user.admin? || user.professor?
  end

  def update?
   user.admin? || user.professor?
  end
end
