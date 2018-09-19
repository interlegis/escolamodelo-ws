class AddUniquenessToInitialsOnSchools < ActiveRecord::Migration[5.2]
  def change
    add_index :schools, :initials, unique: true
  end
end
