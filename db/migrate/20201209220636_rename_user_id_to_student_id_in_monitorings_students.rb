class RenameUserIdToStudentIdInMonitoringsStudents < ActiveRecord::Migration[6.0]
  def change
    rename_column :monitorings_students, :user_id, :student_id
  end
end
