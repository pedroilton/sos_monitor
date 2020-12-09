class AcademicYear < ApplicationRecord
  has_many :classes

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
