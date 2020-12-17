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
    admin_or_profesor?
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
