class RenameUserIdToProfessorIdInUniversityClasses < ActiveRecord::Migration[6.0]
  def change
    rename_column :university_classes, :user_id, :professor_id
  end
end
