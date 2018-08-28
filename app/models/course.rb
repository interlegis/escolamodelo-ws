class Course < ApplicationRecord
  belongs_to :school
  belongs_to :course_category
  has_one_attached :logo
end
