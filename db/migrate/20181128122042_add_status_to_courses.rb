class AddStatusToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :status, :string
  end
end
