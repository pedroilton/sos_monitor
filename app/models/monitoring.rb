class Monitoring < ApplicationRecord
  belongs_to :class_monitor
  has_many :monitorings_students, dependent: :destroy

  validates :date_time, presence: true
end
