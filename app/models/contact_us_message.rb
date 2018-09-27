class ContactUsMessage < ApplicationRecord
  has_one :school
  has_one :course_category
  has_one :course
  belongs_to :ContactUsConversation, optional: true
  after_initialize :init
  # validates :name, :school_initial, :cpf, presence: true
  paginates_per 2
  def init
    self.was_answered ||= false
    # self.is_student ||= true
  end
end
