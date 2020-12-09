class ClassMonitor < ApplicationRecord
  belongs_to :university_class
  belongs_to :user
  has_many :monitorings
end
