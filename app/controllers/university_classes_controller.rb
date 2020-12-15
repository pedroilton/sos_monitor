class UniversityClassesController < ApplicationController
  def index
    @universityClasses = policy_scope(UniversityClass).all
    # .includes(:discipline)
    # @disciplines = Discipline.all.sort_by { |discipline| discipline.title }
    # @universityClasses = policy_scope(UniversityClass).all.order(discipline: :desc)
  end
end
