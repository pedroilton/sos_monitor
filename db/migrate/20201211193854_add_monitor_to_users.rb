class AddMonitorToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :monitor, :boolean, default: false
  end
end
