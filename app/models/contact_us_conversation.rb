class ContactUsConversation < ApplicationRecord
  has_many :contact_us_message, :dependent => :destroy
  belongs_to :user
  paginates_per 100
end
