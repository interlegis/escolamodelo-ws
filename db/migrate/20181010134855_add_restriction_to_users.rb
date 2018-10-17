class AddRestrictionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :restriction, :boolean, :default => false
  end
end
