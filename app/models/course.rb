class Course < ApplicationRecord
  has_many :users
  has_many :disciplines

  validates :title, presence: true
  validates :code, presence: true
end
