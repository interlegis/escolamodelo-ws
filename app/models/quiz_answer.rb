class QuizAnswer < ApplicationRecord
  belongs_to :quiz_question
  has_many :user_quiz_answers
end
