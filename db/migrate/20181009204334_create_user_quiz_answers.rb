class CreateUserQuizAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_quiz_answers do |t|
      t.references :course_registration, foreign_key: true
      t.references :quiz_answer, foreign_key: true

      t.timestamps
    end
  end
end
