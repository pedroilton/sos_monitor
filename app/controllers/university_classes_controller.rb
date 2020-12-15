class UniversityClassesController < ApplicationController
  def index
    @university_classes = policy_scope(UniversityClass).sort_by do |university_class|
      [university_class.discipline.title, university_class.title]
    end
  end

  def show
    @university_class = UniversityClass.find(params[:id])
    authorize @university_class
  end
end
