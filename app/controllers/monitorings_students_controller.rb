class MonitoringsStudentsController < ApplicationController
  after_action :authorize_monitorings_student, except: :leave

  def create
    @monitoring = Monitoring.find(params[:monitoring_id])
    @monitorings_student = MonitoringsStudent.create(student: User.find(params[:monitorings_student][:student]),
                                                     monitoring: @monitoring)
    redirect_to @monitoring
  end

  def destroy
    @monitorings_student = MonitoringsStudent.find(params[:id])
    @monitoring = @monitorings_student.monitoring
    @monitorings_student.destroy
    redirect_to @monitoring
  end

  def leave
    @monitoring = Monitoring.find(params[:monitoring_id])
    @monitorings_student = MonitoringsStudent.find_by(student: current_user, monitoring: @monitoring)
    authorize @monitorings_student
    @monitorings_student.destroy
    redirect_to monitorings_path
  end

  def update
    @monitorings_student = MonitoringsStudent.find(params[:id])
    @monitorings_student.rating = params[:rating].to_i
    @monitorings_student.review = params[:monitorings_student][:review]
    if @monitorings_student.save
      redirect_to @monitorings_student.monitoring
    else
      render @monitorings_student.monitoring
    end
  end

  private

  def authorize_monitorings_student
    authorize @monitorings_student
  end

  def monitorings_student_params
    params.require(:monitorings_student).permit(:monitor, :student, :rating, :review)
  end
end
