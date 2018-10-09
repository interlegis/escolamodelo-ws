class CreateQuizQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_questions do |t|
      t.text :question
      t.references :quiz, foreign_key: true

      t.timestamps
    end
  end
end
