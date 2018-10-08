class ContactUsConversation < ApplicationRecord
  has_many :contact_us_message, :dependent => :destroy
  paginates_per 100
  after_initialize :init

  def init
    self.was_answered ||= false
    # self.is_student ||= true
  end
end
