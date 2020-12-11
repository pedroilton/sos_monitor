class RemoveDepartmentIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :department_id
  end
end
