class DisciplinesController < ApplicationController
  before_action :set_discipline, only: %i[edit update]

  # Disciplinas atuais do aluno
  def student_disciplines
    @academic_year = AcademicYear.where(['start_date <= ? and end_date >= ?', Date.today, Date.today]).first
    @disciplines = policy_scope(Discipline).select do |discipline|
      current_user.classes_students.map do |class_student|
        class_student.university_class.discipline
      end.include? discipline
    end
    @disciplines.select! do |discipline|
      discipline.university_classes.select do |university_class|
        university_class.academic_year == @academic_year
      end
    end
    @disciplines.sort_by!(&:title)
    @available_dates = (Date.today..@academic_year.end_date).to_a..map { |date| date.strftime('%d/%m/%Y') }.uniq.join('-')
    @available_dates = @monitorings.map { |monitoring| monitoring.date_time.strftime('%d/%m/%Y') }.uniq.join('-')
  end

  def index
    @disciplines = policy_scope(Discipline).select { |discipline| discipline.active? }
    @disciplines.sort_by!(&:title)
  end

  def new
    @discipline = Discipline.new
    authorize @discipline
  end

  def create
    @discipline = Discipline.new(discipline_params)
    authorize @discipline
    if @discipline.save
      redirect_to disciplines_path, notice: "Disciplina #{@discipline.title.upcase} criada com sucesso."
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
