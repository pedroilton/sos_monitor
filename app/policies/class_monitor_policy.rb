class ClassMonitorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    user.admin || record.university_class.professor == user
  end
end
