class CreateUniversityClasses < ActiveRecord::Migration[6.0]
  def change
    create_table :university_classes do |t|
      t.string :title
      t.references :discipline, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :academic_year, null: false, foreign_key: true

      t.timestamps
    end
  end
end
