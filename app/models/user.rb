class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :course

  has_many :classes_students, foreign_key: 'student_id'
  has_many :university_classes, foreign_key: 'professor_id'
  has_many :monitors, foreign_key: 'student_id'
  has_many :monitorings_students, foreign_key: 'student_id'

  validates :name, presence: true
  validates :nickname, presence: true

  def student?
    student
  end

  def professor?
    professor
  end

  def coordinator?
    coordinator
  end

  def admin?
    admin
  end
end
