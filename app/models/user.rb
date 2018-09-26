class User < ApplicationRecord
  authenticates_with_sorcery!
  attr_accessor :skip_password, :uid
  validates :password, length: { minimum: 8 }, unless: :skip_password
  validates :password, confirmation: true
  validates :email, uniqueness: true
  validates :cpf, length: { is: 14 }, uniqueness: true
  before_save :capitalize_name
  belongs_to :role
  has_many :certificates
  def capitalize_name
    self.first_name=self.first_name.split.map(&:capitalize).join(' ')
    if self.last_name.present?
      self.last_name=self.last_name.split.map(&:capitalize).join(' ')
    else
      self.last_name = self.first_name.split[1..-1].join(' ')
      self.first_name = self.first_name.split[0]
    end
    if !self.role_id.present?
      self.role_id = 2
    end
  end
  has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
end
