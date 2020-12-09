class RenameUserIdToStudentIdInClassMonitors < ActiveRecord::Migration[6.0]
  def change
    rename_column :class_monitors, :user_id, :student_id
  end
end
