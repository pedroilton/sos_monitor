class RemoveCourseIdFromDisciplines < ActiveRecord::Migration[6.0]
  def change
    remove_column :disciplines, :course_id
  end
end
