class UserQuizAnswer < ApplicationRecord
  belongs_to :course_registration
  belongs_to :quiz_answer
end
