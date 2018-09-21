class AddInitialsToSchools < ActiveRecord::Migration[5.2]
  def change
    add_column :schools, :initials, :string
  end
end
