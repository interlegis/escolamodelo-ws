module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :course, CourseType, null: false do
      description "Find a course by ID"
      argument :id, ID, required: true
    end
    field :courses, [CourseType], null: false do
      description "Find a course by ID"
    end
    def course(id:)
      Course.find(id)
    end
    def courses
      Course.all
    end
  end
end
