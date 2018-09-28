class ContactUsMessage < ApplicationRecord
  has_one :school
  has_one :course_category
  has_one :course
  belongs_to :ContactUsConversation, optional: true
  # validates :name, :school_initial, :cpf, presence: true
end
