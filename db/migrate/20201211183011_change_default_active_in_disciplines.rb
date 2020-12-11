class ChangeDefaultActiveInDisciplines < ActiveRecord::Migration[6.0]
  def change
    change_column_default :disciplines, :active, true
  end
end
