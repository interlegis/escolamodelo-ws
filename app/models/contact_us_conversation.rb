class ContactUsConversation < ApplicationRecord
  has_many :contact_us_message, :dependent => :destroy
  paginates_per 100
  after_initialize :init

  def init
    self.was_answered ||= false
  end
end
