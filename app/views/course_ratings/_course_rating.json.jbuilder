json.extract! course_rating, :id, :course_id, :user_id, :rating, :observation, :created_at, :updated_at
json.url course_rating_url(course_rating, format: :json)
