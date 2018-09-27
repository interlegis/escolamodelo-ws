class AddTitleAndDescriptionAndInitialDateToContactUsConversations < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_us_conversations, :title, :string
    add_column :contact_us_conversations, :description, :string
    add_column :contact_us_conversations, :initial_date, :date
  end
end
