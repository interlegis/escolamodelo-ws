class ContactUsMessage < ApplicationRecord
  has_one :school
  has_one :course_category
  has_one :course
  paginates_per 2

end
