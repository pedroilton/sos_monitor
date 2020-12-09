class RenameUserIdToStudentIdInClassesStudents < ActiveRecord::Migration[6.0]
  def change
    rename_column :classes_students, :user_id, :student_id
  end
end
