class CreateContactUsMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_us_messages do |t|
      t.string :name
      t.string :email
      t.string :cpf
      t.string :description
      t.datetime :date

      t.timestamps
    end
  end
end
