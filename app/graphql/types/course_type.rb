module Types
  class CourseType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :url, String, null: true
    field :course_load, Integer, null: true
    field :description, String, null: true
    field :ead_id, Integer, null: true
    field :category, CourseCategoryType, null: false
    field :school, SchoolType, null: false
  end
end
