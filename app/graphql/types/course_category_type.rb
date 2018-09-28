module Types
  class CourseCategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :logo, String, null: true
    field :courses, [CourseType], null: true
  end
end
