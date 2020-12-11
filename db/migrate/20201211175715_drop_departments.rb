class DropDepartments < ActiveRecord::Migration[6.0]
  def change
    drop_table :departments
  end
end
