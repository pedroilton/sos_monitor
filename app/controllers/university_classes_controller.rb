class UniversityClassesController < ApplicationController
  def index
    @university_classes = policy_scope(UniversityClass).sort_by do |university_class|
      [university_class.discipline.title, university_class.title]
    end
  end

  def show
    @university_class = UniversityClass.find(params[:id])
    @class_monitor = ClassMonitor.new
    @available_monitors = User.all.select(&:student?).reject do |user|
      @university_class.students.include?(user) || @university_class.class_monitors.map(&:student).include?(user)
    end
    authorize @university_class
  end
end
