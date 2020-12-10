class ClassesStudent < ApplicationRecord
  belongs_to :university_class
  belongs_to :student, class_name: 'User', foreign_key: 'student_id', validate: true
end
