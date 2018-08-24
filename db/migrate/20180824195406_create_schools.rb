class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :url
      t.string :url_logo

      t.timestamps
    end
  end
end
