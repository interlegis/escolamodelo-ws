class AddTagToQuizQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :quiz_questions, :tag, :string
  end
end
