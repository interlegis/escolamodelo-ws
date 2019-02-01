require "application_system_test_case"

class CourseRatingsTest < ApplicationSystemTestCase
  setup do
    @course_rating = course_ratings(:one)
  end

  test "visiting the index" do
    visit course_ratings_url
    assert_selector "h1", text: "Course Ratings"
  end

  test "creating a Course rating" do
    visit course_ratings_url
    click_on "New Course Rating"

    fill_in "Course", with: @course_rating.course_id
    fill_in "Observation", with: @course_rating.observation
    fill_in "Rating", with: @course_rating.rating
    fill_in "User", with: @course_rating.user_id
    click_on "Create Course rating"

    assert_text "Course rating was successfully created"
    click_on "Back"
  end

  test "updating a Course rating" do
    visit course_ratings_url
    click_on "Edit", match: :first

    fill_in "Course", with: @course_rating.course_id
    fill_in "Observation", with: @course_rating.observation
    fill_in "Rating", with: @course_rating.rating
    fill_in "User", with: @course_rating.user_id
    click_on "Update Course rating"

    assert_text "Course rating was successfully updated"
    click_on "Back"
  end

  test "destroying a Course rating" do
    visit course_ratings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course rating was successfully destroyed"
  end
end
