class CoursesController < ApplicationController
  skip_before_action :verify_authenticity_token
  #Adicionar token para que apenas acesso permitido possa acessar os métodos
  # Acrescentar mensagens de erro
  # Acrescentar campo ead_id ou moodle_id
  # Corrigir school_id
  def adicionar_curso
    @course = Course.new(curso_params)
    @course.save
    render status: 200, json: {
        message: "Curso criado com sucesso",
    }.to_json
  end
  def atualizar_curso
    @course = Course.find_by(ead_id: curso_params[:ead_id], school_id: curso_params[:school_id])
    @course.save
    render status: 200, json: {
        message: "Curso atualizado com sucesso",
    }.to_json
  end


  private
  def curso_params
    params.require(:course).permit(:name, :course_category_id, :school_id, :course_load, :description, :ead_id)
  end
end