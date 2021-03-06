class Course < ApplicationRecord
  has_many :users
  has_many :disciplines

  belongs_to :department

  validates :title, presence: true
  validates :code, presence: true
end
