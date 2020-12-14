class DisciplinePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.select(&:active)
    end
  end
end
