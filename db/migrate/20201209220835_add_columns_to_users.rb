class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :phone_number, :string
    add_reference :users, :course, foreign_key: true
    add_column :users, :student, :boolean, default: false
    add_column :users, :prfessor, :boolean, default: false
    add_column :users, :coordinator, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
  end
end
