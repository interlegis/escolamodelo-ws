class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
      t.string :tag
      t.string :title
      t.string :link
      t.string :icon

      t.timestamps
    end
  end
end
