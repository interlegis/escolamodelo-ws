class RemoveUserIdFromContactUsConversations < ActiveRecord::Migration[5.2]
  def change
    remove_column :contact_us_conversations, :user_id, :bigint
  end
end
