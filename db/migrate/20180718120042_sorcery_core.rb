class SorceryCore < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username,         :null => false
      t.string :email,            :null => false
      t.string :cpf,              :null => false
      t.string :first_name
      t.string :last_name
      t.date :birth
      t.string :phone
      t.string :crypted_password
      t.string :salt

      t.timestamps                :null => false
    end

    add_index :users, [:username, :email, :cpf], unique: true
  end
end
