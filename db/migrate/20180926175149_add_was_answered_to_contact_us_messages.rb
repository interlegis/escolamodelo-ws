class AddWasAnsweredToContactUsMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_us_messages, :was_answered, :boolean
  end
end
