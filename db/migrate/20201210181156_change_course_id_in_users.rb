class ChangeCourseIdInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :course_id, true
  end
end
