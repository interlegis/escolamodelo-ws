class User < ApplicationRecord
  # authenticates_with_sorcery!
  attr_accessor :skip_password, :uid, :redirect_page
  validates :cpf, length: { is: 14 }, uniqueness: true
  has_many :certificates
  has_many :contact_us_conversations
  has_many :course_registrations
  has_one_attached :avatar
end
