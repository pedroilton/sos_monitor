class Department < ApplicationRecord
  has_many :courses
  has_many :users

  validates :title, presence: true
  validates :code, presence: true
end
