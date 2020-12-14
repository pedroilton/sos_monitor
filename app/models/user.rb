class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, authentication_keys: [:registration]

  has_many :classes_students, foreign_key: 'student_id'
  has_many :university_classes, foreign_key: 'professor_id'
  has_many :class_monitors, foreign_key: 'student_id'
  has_many :monitorings_students, foreign_key: 'student_id'

  has_many :monitorings, through: :monitorings_students

  validates :name, presence: true
  validates :email, uniqueness: false

  def active?
    active
  end

  def student?
    student
  end

  def monitor?
    current_monitors = []
    AcademicYear.where(['start_date < ? and end_date > ?', Date.today, Date.today]).first.university_classes.each do
      |university_class|
      university_class.class_monitors.each do |monitor|
        current_monitors << monitor.student
      end
    end
    current_monitors.include? self
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
