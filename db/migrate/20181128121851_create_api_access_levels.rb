class CreateApiAccessLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :api_access_levels do |t|
      t.string :name

      t.timestamps
    end
  end
end
