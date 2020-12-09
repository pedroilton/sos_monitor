class Monitoring < ApplicationRecord
  belongs_to :class_monitor
  has_many :monitorings_students

  validates :date_time, presence: true
end
