class ChangeDefaultActiveInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :active, true
  end
end
