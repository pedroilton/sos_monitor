class Discipline < ApplicationRecord
  has_many :classes

  validates :title, presence: true
  validates :code, presence: true

  def active?
    active
  end
end
