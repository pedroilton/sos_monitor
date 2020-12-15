class UniversityClassesController < ApplicationController
  def index
    @universityClasses = policy_scope(UniversityClass).all
  end

  def new
    @disciplines = Discipline.all
    @universityClass = UniversityClass.new
    authorize @universityClass
  end

  def create
    @universityClass = UniversityClass.new(universityClass_params)
    authorize @universityClass
    if @universityClass.save
      redirect_to new_universityClasss_path
    else
      render :new
    end
  end

  def edit
    authorize @universityClass
  end

  def update
    authorize @universityClass

    if @universityClass.update(universityClass_params)
      redirect_to universityClasss_path, notice: 'Turma atualizada com sucesso.'
    else
      render :edit
    end
  end

  private

  def set_universityClass
    @universityClass = UniversityClass.find(params[:id])
  end

  def universityClass_params
    params.require(:universityClass).permit(:title, :code, :active)
  end
end
