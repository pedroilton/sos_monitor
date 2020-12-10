class AddRegistrationToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :registration, :string
  end
end
