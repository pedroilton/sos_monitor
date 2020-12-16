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

  def edit?
    create?
  end

  def update?
    create?
  end

  def destroy_schedule?
    create?
  end

  def monitor_day?
    user.admin || record.university_class.professor == user || record.student == user
  end
end
