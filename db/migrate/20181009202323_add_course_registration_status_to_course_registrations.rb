class AddCourseRegistrationStatusToCourseRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_reference :course_registrations, :course_registration_status, foreign_key: true
  end
end
