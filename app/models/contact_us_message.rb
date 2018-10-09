class ContactUsMessage < ApplicationRecord
  has_one :school
  has_one :course_category
  has_one :course
  belongs_to :ContactUsConversation, optional: true
  # validates :name, :school_initial, :cpf, presence: true
  after_initialize :init

  def init
    self.is_student ||= true
  end
end
