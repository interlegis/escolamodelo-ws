require 'test_helper'

class CourseRatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_rating = course_ratings(:one)
  end

  test "should get index" do
    get course_ratings_url
    assert_response :success
  end

  test "should get new" do
    get new_course_rating_url
    assert_response :success
  end

  test "should create course_rating" do
    assert_difference('CourseRating.count') do
      post course_ratings_url, params: { course_rating: { course_id: @course_rating.course_id, observation: @course_rating.observation, rating: @course_rating.rating, user_id: @course_rating.user_id } }
    end

    assert_redirected_to course_rating_url(CourseRating.last)
  end

  test "should show course_rating" do
    get course_rating_url(@course_rating)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_rating_url(@course_rating)
    assert_response :success
  end

  test "should update course_rating" do
    patch course_rating_url(@course_rating), params: { course_rating: { course_id: @course_rating.course_id, observation: @course_rating.observation, rating: @course_rating.rating, user_id: @course_rating.user_id } }
    assert_redirected_to course_rating_url(@course_rating)
  end

  test "should destroy course_rating" do
    assert_difference('CourseRating.count', -1) do
      delete course_rating_url(@course_rating)
    end

    assert_redirected_to course_ratings_url
  end
end
