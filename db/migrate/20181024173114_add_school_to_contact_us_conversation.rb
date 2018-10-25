class AddSchoolToContactUsConversation < ActiveRecord::Migration[5.2]
  def change
    add_reference :contact_us_conversations, :school, foreign_key: true
  end
end
