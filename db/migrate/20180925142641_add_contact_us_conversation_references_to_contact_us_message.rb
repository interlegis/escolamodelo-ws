class AddContactUsConversationReferencesToContactUsMessage < ActiveRecord::Migration[5.2]
  def change
    add_reference :contact_us_messages, :contact_us_conversation, foreign_key: true
  end
end
