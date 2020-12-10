class MonitoringsStudent < ApplicationRecord
  belongs_to :student, class_name: 'User', foreign_key: 'student_id', validate: true
  belongs_to :monitoring
end
