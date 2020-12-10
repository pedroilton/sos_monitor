class UniversityClass < ApplicationRecord
  belongs_to :discipline
  belongs_to :professor, class_name: 'User', foreign_key: 'professor_id', validate: true
  belongs_to :academic_year

  has_many :classes_students
  has_many :monitors

  validates :title, presence: true
end
