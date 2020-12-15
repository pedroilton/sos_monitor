class ClassMonitorsController < ApplicationController
  def create
    @university_class = UniversityClass.find(params[:university_class_id])
    @class_monitor = ClassMonitor.create(student: User.find(params[:class_monitor][:student]),
                                         university_class: @university_class)
    redirect_to @university_class
    authorize @class_monitor
  end

  def destroy
    @class_monitor = ClassMonitor.find(params[:id])
    @university_class = @class_monitor.university_class
    authorize @class_monitor
    @class_monitor.destroy
    redirect_to @university_class
  end
end
