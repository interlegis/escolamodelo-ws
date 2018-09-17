class CreateCertificates < ActiveRecord::Migration[5.2]
  def change
    create_table :certificates do |t|
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.date :issue_date
      t.float :grade
      t.string :code_id

      t.timestamps
    end
  end
end
