class CreateContactUsConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_us_conversations do |t|

      t.timestamps
    end
  end
end

# rails generate migration add_title_and_description_and_initial_date_to_contact_us_conversations title:string description:string initial_date:date
