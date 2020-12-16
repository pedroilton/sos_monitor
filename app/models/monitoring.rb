class Monitoring < ApplicationRecord
  attribute :place, :string, default: 'Sala de estudos'

  belongs_to :class_monitor

  has_many :monitorings_students, dependent: :destroy

  has_many :students, through: :monitorings_students

  validates :date_time, presence: true
end
