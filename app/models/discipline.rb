class Discipline < ApplicationRecord
  has_many :university_classes

  validates :title, presence: true
  validates :code, presence: true, uniqueness: true

  def active?
    active
  end
end
