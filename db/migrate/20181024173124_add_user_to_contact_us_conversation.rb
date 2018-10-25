class AddUserToContactUsConversation < ActiveRecord::Migration[5.2]
  def change
    add_reference :contact_us_conversations, :user, foreign_key: true
  end
end
