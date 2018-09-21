class ChangeNullCpfToTrueOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :cpf, :string, :null => true
  end
end
