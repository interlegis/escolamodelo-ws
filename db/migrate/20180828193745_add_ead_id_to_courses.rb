class AddEadIdToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :ead_id, :integer
  end
end
