class AddIsStudentToContactUsMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_us_messages, :is_student, :boolean
  end
end
