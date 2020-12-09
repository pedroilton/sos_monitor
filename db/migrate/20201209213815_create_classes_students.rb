class CreateClassesStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :classes_students do |t|
      t.references :university_class, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
