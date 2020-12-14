class DisciplinesController < ApplicationController
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
          AcademicYear.where(['start_date < ? and end_date > ?', Date.today, Date.today]).first
      end
    end
  end
end
