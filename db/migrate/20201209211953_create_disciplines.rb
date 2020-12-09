class CreateDisciplines < ActiveRecord::Migration[6.0]
  def change
    create_table :disciplines do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title
      t.string :code

      t.timestamps
    end
  end
end
