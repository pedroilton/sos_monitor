class UniversityClass < ApplicationRecord
  belongs_to :discipline
  belongs_to :user
  belongs_to :academic_year

  has_many :classes_students
  has_many :monitors

  validates :title, presence: true
end
