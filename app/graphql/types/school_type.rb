module Types
  class SchoolType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :url, String, null: true
    field :courses, [CourseType], null: true
    field :logo, String, null: true
  end
end
