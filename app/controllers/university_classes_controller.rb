class UniversityClassesController < ApplicationController
  def index
    @discipline = Discipline.new
    @disciplines = Discipline.all
    @universityClasses = policy_scope(UniversityClass).all
    # @universityClasses = policy_scope(UniversityClass).all.order(discipline: :desc)
  end
end
