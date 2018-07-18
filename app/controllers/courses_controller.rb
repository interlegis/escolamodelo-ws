class CoursesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def adicionar_curso
    @course = Course.new(curso_params)
    @course.save
  end

  private
  def curso_params
    params.require(:course).permit(:name)
  end
end
