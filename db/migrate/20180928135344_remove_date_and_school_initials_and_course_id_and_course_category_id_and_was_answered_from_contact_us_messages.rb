class RemoveDateAndSchoolInitialsAndCourseIdAndCourseCategoryIdAndWasAnsweredFromContactUsMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :contact_us_messages, :date, :datetime
    remove_column :contact_us_messages, :school_initials, :string
    remove_column :contact_us_messages, :course_id, :bigint
    remove_column :contact_us_messages, :course_category_id, :bigint
    remove_column :contact_us_messages, :was_answered, :boolean
  end
end
