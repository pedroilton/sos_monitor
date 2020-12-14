class MonitoringsStudentsController < ApplicationController
  after_action :authorize_monitorings_student, except: :leave

  def create
    @monitorings_student = MonitoringsStudent.create(student: User.find(params[:monitorings_student][:student]),
                                                     monitoring: Monitoring.find(params[:monitoring_id]))
    redirect_to Monitoring.find(params[:monitoring_id])
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

  private

  def authorize_monitorings_student
    authorize @monitorings_student
  end
end