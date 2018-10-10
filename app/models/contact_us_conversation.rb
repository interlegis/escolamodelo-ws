class ContactUsConversation < ApplicationRecord
  has_many :contact_us_message, :dependent => :destroy
  paginates_per 100
end
