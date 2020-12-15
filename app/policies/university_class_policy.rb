class UniversityClassPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user.admin?

      scope.select do |university_class|
        university_class.professor == user && university_class.academic_year.start_date <= Date.today &&
          university_class.academic_year.end_date >= Date.today
      end
    end
  end

  def show?
    user.admin? || user == record.professor
  end
end
