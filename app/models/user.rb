class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :course

  has_many :classes_students
  has_many :university_classes
  has_many :monitors
  has_many :monitorings_students

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
