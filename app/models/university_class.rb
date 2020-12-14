class UniversityClass < ApplicationRecord
  belongs_to :discipline
  belongs_to :professor, class_name: 'User', foreign_key: 'professor_id', validate: true
  belongs_to :academic_year

  has_many :classes_students, dependent: :destroy
  has_many :class_monitors, dependent: :destroy

  validates :title, presence: true
end
