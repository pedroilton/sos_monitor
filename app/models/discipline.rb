class Discipline < ApplicationRecord
  belongs_to :course
  has_many :classes

  validates :title, presence: true
  validates :code, presence: true
end
