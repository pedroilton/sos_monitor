class DisciplinesController < ApplicationController
  before_action :set_discipline, only: %i[edit update]

  # Disciplinas atuais do aluno
  def student_disciplines
    @disciplines = policy_scope(Discipline).select do |discipline|
      current_user.classes_students.map do |class_student|
        class_student.university_class.discipline
      end.include? discipline
    end
    @disciplines.select! do |discipline|
      discipline.university_classes.select do |university_class|
        university_class.academic_year ==
          AcademicYear.where(['start_date <= ? and end_date >= ?', Date.today, Date.today]).first
      end
    end
    @disciplines.sort_by!(&:title)
  end

  def index
    # @disciplines = policy_scope(Discipline).order(title: :desc)
    @disciplines = policy_scope(Discipline)
    @discipline = Discipline.new
    @disciplines = Discipline.all.sort
  end

  def new
    @discipline = Discipline.new
    authorize @discipline
  end

  def create
    @discipline = Discipline.new(discipline_params)
    authorize @discipline
    if @discipline.save
      redirect_to new_disciplines_path
    else
      render :new
    end
  end

  def edit
    authorize @discipline
  end

  def update
    authorize @discipline

    if @discipline.update(discipline_params)
      redirect_to disciplines_path, notice: 'Disciplina atualizada com sucesso.'
    else
      render :edit
    end
  end

  private

  def set_discipline
    @discipline = Discipline.find(params[:id])
  end

  def discipline_params
    params.require(:discipline).permit(:title, :code, :active)
  end
end
