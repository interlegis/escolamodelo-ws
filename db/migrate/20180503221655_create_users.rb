class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :cpf

      t.timestamps
    end
    add_index :users, [:cpf], unique: true
  end
end
