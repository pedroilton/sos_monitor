class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, authentication_keys: [:registration]

  has_many :classes_students, foreign_key: 'student_id'
  has_many :university_classes, foreign_key: 'professor_id'
  has_many :monitors, foreign_key: 'student_id'
  has_many :monitorings_students, foreign_key: 'student_id'

  validates :name, presence: true
  validates :email, uniqueness: false
  # validates :course_id, presence: false

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

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    registration = conditions.delete(:registration)
    if registration
      where(conditions).where(["lower(registration) = :value", { value: registration.downcase }]).first
    elsif conditions[:registration].nil?
      where(conditions).first
    else
      where(registration: conditions[:registration]).first
    end
  end
end
