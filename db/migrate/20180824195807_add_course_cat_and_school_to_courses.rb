class AddCourseCatAndSchoolToCourses < ActiveRecord::Migration[5.2]
  def change
    add_reference :courses, :course_category, foreign_key: true
    add_reference :courses, :school, foreign_key: true
    add_column    :courses, :url, :string
    add_column    :courses, :course_load, :integer
    add_column    :courses, :description, :text
  end
end
