class AddApiAccessLevelToApiAccesses < ActiveRecord::Migration[5.2]
  def change
    add_reference :api_accesses, :api_access_level, foreign_key: true
  end
end
