class ChangeRegistrationInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :registration, false
  end
end
