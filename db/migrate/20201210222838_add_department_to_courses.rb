class AddDepartmentToCourses < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :department, index: true
  end
end
