class AddIndexToRegistrationInUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :registration, unique: true
  end
end
