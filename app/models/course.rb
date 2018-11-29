class Course < ApplicationRecord
  belongs_to :school
  belongs_to :course_category, optional: true
  has_one_attached :logo
  has_many :certificates
  has_many :course_registrations
end
