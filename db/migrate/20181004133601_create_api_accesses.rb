class CreateApiAccesses < ActiveRecord::Migration[5.2]
  def change
    create_table :api_accesses do |t|
      t.string :key, :null => false
      t.integer :access_level
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :api_accesses, [:key], unique: true
  end
end
