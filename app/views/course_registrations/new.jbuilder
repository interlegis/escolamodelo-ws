json.quiz do
  json.array! @quiz_questions do |question|
    json.id question.id
    json.question question.question
    json.answers do
      json.array! question.quiz_answers, :id, :answer
    end
  end
end