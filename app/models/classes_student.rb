class ClassesStudent < ApplicationRecord
  belongs_to :university_class
  belongs_to :user
end
