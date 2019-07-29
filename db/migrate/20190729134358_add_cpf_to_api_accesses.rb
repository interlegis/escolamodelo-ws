class AddCpfToApiAccesses < ActiveRecord::Migration[5.2]
  def change
    add_column :api_accesses, :cpf, :string
  end
end
