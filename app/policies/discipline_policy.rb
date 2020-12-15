class DisciplinePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.select(&:active)
    end
  end

  def create?
    user.admin?
  end

  def new?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end
end
