class CreateCourseRegistrationStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :course_registration_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
