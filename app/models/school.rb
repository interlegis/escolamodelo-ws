class School < ApplicationRecord
  has_many :courses
  has_one_attached :logo
end
