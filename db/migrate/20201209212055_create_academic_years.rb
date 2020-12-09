class CreateAcademicYears < ActiveRecord::Migration[6.0]
  def change
    create_table :academic_years do |t|
      t.string :title
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
