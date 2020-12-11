class AddActiveToDisciplines < ActiveRecord::Migration[6.0]
  def change
    add_column :disciplines, :active, :boolean
  end
end
