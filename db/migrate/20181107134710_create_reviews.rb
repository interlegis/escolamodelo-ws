class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :autor
      t.string :cargo
      t.string :cidade
      t.string :uf
      t.string :opiniao

      t.timestamps
    end
  end
end
