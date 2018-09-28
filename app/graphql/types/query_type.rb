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
      description "Find all courses"
    end
    field :school, SchoolType, null: false do
      description "Find a school by Initial"
      argument :initials, String, required: true
    end
    field :schools, [SchoolType], null: false do
      description "Find all schools"
    end
    field :category, CourseCategoryType, null: false do
      description "Find a category by ID"
      argument :id, ID, required: true
    end
    field :categories, [CourseCategoryType], null: false do
      description "Find all categories"
    end
    def course(id:)
      Course.find(id)
    end
    def courses
      Course.all
    end
    def school(initials:)
      Course.find_by(initials: initials)
    end
    def schools
      School.all
    end
    def category(id:)
      CourseCategory.find(id)
    end
    def categories
      CourseCategory.all
    end
  end
end
