class RemoveUserAndApiAccessLevelFromApiAccesses < ActiveRecord::Migration[5.2]
  def change
    remove_column :api_accesses, :user_id, :string
    remove_column :api_accesses, :api_access_level_id, :string
  end
end
