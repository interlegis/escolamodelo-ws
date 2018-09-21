class AddCourseCatAndSchoolAndCourseToContactUsMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_us_messages, :school_initials, :string
    add_column :contact_us_messages, :course_id, :bigint
    add_column :contact_us_messages, :course_category_id, :bigint
  end
end
