class AddVisibleToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :visible, :boolean
  end
end
