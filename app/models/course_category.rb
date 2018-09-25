class CourseCategory < ApplicationRecord
  has_many :courses
  has_one_attached :logo
  before_save :capitalize_name
  def capitalize_name
    self.name=self.name.split.map(&:capitalize).join(' ')
  end
end