class MonitoringPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      current_monitorings = scope.select do |monitoring|
        monitoring.class_monitor.university_class.academic_year ==
          AcademicYear.where(['start_date < ? and end_date > ?', Date.today, Date.today]).first
      end

      return current_monitorings if user.admin?

      if user.professor?
        return current_monitorings.select { |monitoring| monitoring.class_monitor.university_class.professor == user }
      end

      student_monitorings = current_monitorings.select { |monitoring| monitoring.students.include? user }
      if user.monitor?
        student_monitorings += current_monitorings.select { |monitoring| monitoring.class_monitor.student == user }
      end
      student_monitorings
    end
  end
end
