class MonitoringsController < ApplicationController
  def index
    @monitorings = policy_scope(Monitoring).select { |monitoring| monitoring.students.include? current_user }
  end

  def list
    @monitorings = policy_scope(Monitoring).reject { |monitoring| monitoring.students.include? current_user }
  end
end
