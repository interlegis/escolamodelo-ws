class AddCertificadorAndConteudistaAndCargaHorariaToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :certificador, :string
    add_column :courses, :conteudista, :string
    add_column :courses, :carga_horaria, :integer
  end
end
