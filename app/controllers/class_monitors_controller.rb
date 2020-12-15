class ClassMonitorsController < ApplicationController
  def destroy
    @class_monitor = ClassMonitor.find(params[:id])
    @university_class = @class_monitor.university_class
    authorize @class_monitor
    @class_monitor.destroy
    redirect_to @university_class
  end
end
