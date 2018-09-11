class CourseCategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def adicionar_categoria
    @category = CourseCategory.new(course_category_params)
    @category.save
    #@course.logo.attach(io: StringIO.new('https://saberes.senado.leg.br/images/logo_saberes_xl.png'), filename: 'logo_saberes.png', content_type: 'image/png')
    render status: 200, json: {
        message: "Categoria criada com sucesso",
    }.to_json
  end
  def atualizar_categoria
    nome_cat=course_category_params[:name].split.map(&:capitalize).join(' ') if course_category_params[:name].present?
    @category = CourseCategory.find_by(name: nome_cat)
    @category.update(course_category_params)
    #verificar presença de imagem
    render status: 200, json: {
        message: "Categoria atualizada com sucesso",
    }.to_json
  end
  private
  def course_category_params
    params.require(:course_category).permit(:name)
  end
end
