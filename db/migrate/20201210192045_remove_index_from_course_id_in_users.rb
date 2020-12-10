class RemoveIndexFromCourseIdInUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :course_id
  end
end
