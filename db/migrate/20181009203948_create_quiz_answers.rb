class CreateQuizAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_answers do |t|
      t.string :answer
      t.references :quiz_question, foreign_key: true

      t.timestamps
    end
  end
end
