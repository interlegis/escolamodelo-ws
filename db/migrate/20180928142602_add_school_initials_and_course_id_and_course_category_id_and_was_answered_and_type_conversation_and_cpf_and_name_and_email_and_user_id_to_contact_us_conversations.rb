class AddSchoolInitialsAndCourseIdAndCourseCategoryIdAndWasAnsweredAndTypeConversationAndCpfAndNameAndEmailAndUserIdToContactUsConversations < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_us_conversations, :school_initials, :string
    add_column :contact_us_conversations, :course_id, :bigint
    add_column :contact_us_conversations, :course_category_id, :bigint
    add_column :contact_us_conversations, :was_answered, :boolean
    add_column :contact_us_conversations, :type_conversation, :string
    add_column :contact_us_conversations, :cpf, :string
    add_column :contact_us_conversations, :name, :string
    add_column :contact_us_conversations, :email, :string
    add_column :contact_us_conversations, :user_id, :bigint
  end
end
