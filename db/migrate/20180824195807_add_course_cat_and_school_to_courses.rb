class AddCourseCatAndSchoolToCourses < ActiveRecord::Migration[5.2]
  def change
    add_reference :courses, :course_category, foreign_key: true
    add_reference :courses, :school, foreign_key: true
  end
end
