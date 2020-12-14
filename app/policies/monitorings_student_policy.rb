class MonitoringsStudentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin? || user.student?
  end

  def destroy?
    user.admin? || record.monitoring.students.include?(user)
  end

  def leave?
    destroy?
  end
end
