class CourseRegistration < ApplicationRecord
  belongs_to :course
  belongs_to :user
  belongs_to :course_registration_status
  has_many :user_quiz_answers
end
