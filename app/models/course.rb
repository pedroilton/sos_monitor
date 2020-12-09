class Course < ApplicationRecord
  has_many :users
  has_many :disciplines

  validates :title, presence: true
end
