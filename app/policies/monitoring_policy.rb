class MonitoringPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      current_monitorings = scope.select do |monitoring|
        monitoring.class_monitor.university_class.academic_year ==
          AcademicYear.where(['start_date <= ? and end_date >= ?', Date.today, Date.today]).first
      end

      return current_monitorings if user.admin?

      if user.professor?
        return current_monitorings.select { |monitoring| monitoring.class_monitor.university_class.professor == user }
      end

      # Monitorias agendadas para o aluno
      student_monitorings = current_monitorings.select { |monitoring| monitoring.students.include? user }

      # Disciplinas do aluno
      disciplines = user.classes_students.map { |class_student| class_student.university_class.discipline }
      disciplines.select! do |discipline|
        discipline.university_classes.select do |university_class|
          university_class.academic_year ==
            AcademicYear.where(['start_date <= ? and end_date >= ?', Date.today, Date.today]).first
        end
      end

      # Monitorias vagas para as disciplinas do aluno
      student_monitorings += disciplines.map do |discipline|
        discipline.university_classes.map do |university_class|
          university_class.class_monitors.map do |class_monitor|
            class_monitor.monitorings.select do |monitoring|
              monitoring.class_monitor.university_class.academic_year ==
                AcademicYear.where(['start_date <= ? and end_date >= ?', Date.today, Date.today]).first &&
                monitoring.monitorings_students.empty?
            end
          end
        end
      end.flatten

      # Monitorias do monitor
      if user.monitor?
        student_monitorings += current_monitorings.select { |monitoring| monitoring.class_monitor.student == user }
      end
      student_monitorings
    end
  end

  def show?
    user.admin? || record.class_monitor.university_class.professor == user || record.students.include?(user) ||
      record.class_monitor.student == user
  end

  def update?
    user.admin? || record.students.include?(user)
  end

  def schedule?
    user.admin? || user.student?
  end

  def destroy?
    update?
  end

  def cancel?
    user.admin? || record.class_monitor.student == user || record.class_monitor.university_class.professor == user
  end

  def edit_place?
    cancel?
  end
end
