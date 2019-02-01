class CourseRatingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    courses_ratings = CourseRating.all
    hash_ratings = courses_ratings.map do |c|
      {'course_id' => c.course_id,
       'rating' => c.rating,
       'obsevation' => c.observation,
      }
    end
    render status: 200, json: {
        avalicoes: hash_ratings,
    }.to_json
  end

  def avaliar_curso
    if CourseRating.where(course_id: params[:course_rating][:course_id], user_id: params[:course_rating][:user_id]).count == 0
      if (params[:course_rating][:rating]).to_f > 5.0 or (params[:course_rating][:rating]).to_f < 0.0
        render status: 400, json: {
            message: "A nota está fora do intervalo! Coloque uma nota entre 0 e 5.",
        }.to_json
      else
        @course_rating = CourseRating.new(course_rating_params)
        if @course_rating.save
          render status: 200, json: {
              message: "Avaliação feita com sucesso",
          }.to_json
        else
          render status: 400, json: {
              message: "Não foi possível avaliar esse curso",
          }.to_json
        end
      end
    else
      render status: 400, json: {
          message: "A avaliação para este curso já foi feita",
      }.to_json
    end
  end

    def course_rating_params
      params.require(:course_rating).permit(:course_id, :user_id, :rating, :observation)
    end
end
