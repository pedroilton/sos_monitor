class CreateMonitorings < ActiveRecord::Migration[6.0]
  def change
    create_table :monitorings do |t|
      t.references :class_monitor, null: false, foreign_key: true
      t.text :question
      t.string :place
      t.text :excuse
      t.timestamp :date_time

      t.timestamps
    end
  end
end
