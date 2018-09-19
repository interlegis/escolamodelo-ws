class ContactUsMessage < ApplicationRecord
  has_one :school
  has_one :course_category
  has_one :course
end
