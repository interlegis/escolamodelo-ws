class CourseRegistration < ApplicationRecord
  belongs_to :course
  belongs_to :user
  belongs_to :course_registration_status
  has_many :user_quiz_answers
  validates_uniqueness_of :user_id, scope: :course_id
end
