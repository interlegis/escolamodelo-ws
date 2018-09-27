class ContactUsConversation < ApplicationRecord
  has_many :contact_us_message, :dependent => :destroy
end
