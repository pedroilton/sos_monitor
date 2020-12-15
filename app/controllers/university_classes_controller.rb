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

  def new
    @disciplines = Discipline.all
    @university_class = UniversityClass.new
    authorize @university_class
  end

  def create
    @university_class = UniversityClass.new(university_class_params)
    authorize @university_class
    if @university_class.save
      redirect_to new_university_class_path
    else
      render :new
    end
  end

  def edit
    authorize @university_class
  end

  def update
    if @university_class.update(university_class_params)
      redirect_to university_class_path, notice: 'Turma atualizada com sucesso.'
    else
      render :edit
    end
    authorize @university_class
  end

  private

  def set_university_class
    @university_class = UniversityClass.find(params[:id])
  end

  def university_class_params
    params.require(:university_class).permit(:title, :code, :active)
  end
end
