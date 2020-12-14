class AcademicYear < ApplicationRecord
  has_many :university_classes, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
