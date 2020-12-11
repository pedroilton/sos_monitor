class RenamePrfessorToProfessorInUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :prfessor, :professor
  end
end
