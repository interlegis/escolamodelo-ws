class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end
  def adicionar_curso
    @curso = Curso.new(curso_params)
    @curso.save
  end

  private
  def curso_params
    params.require(:curso).permit(:nome)
  end
end
