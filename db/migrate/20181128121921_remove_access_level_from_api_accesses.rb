class RemoveAccessLevelFromApiAccesses < ActiveRecord::Migration[5.2]
  def change
    remove_column :api_accesses, :access_level, :integer
  end
end
