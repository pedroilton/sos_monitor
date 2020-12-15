class ClassMonitorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin || record.university_class.professor == user
  end

  def destroy?
    create?
  end
end
