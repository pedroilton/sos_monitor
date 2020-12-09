class CreateMonitoringsStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :monitorings_students do |t|
      t.references :user, null: false, foreign_key: true
      t.references :monitoring, null: false, foreign_key: true
      t.integer :rating
      t.text :review

      t.timestamps
    end
  end
end
