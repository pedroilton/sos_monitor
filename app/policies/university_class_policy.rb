class UniversityClassPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index
    admin_or_profesor?
  end

  def new?
    admin_or_profesor?
  end

  def create?
    admin_or_profesor?
  end

  def edit?
    admin_or_profesor?
  end

  def update?
    admin_or_profesor?
  end

  def admin_or_profesor?
    user.admin? || user.professor?
  end
end
