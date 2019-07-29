class CourseCategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :admin_access, only: [:adicionar_categoria, :atualizar_categoria]
  before_action :basic_api_access, only: [:index]

  def adicionar_categoria
    @category = CourseCategory.new(:name => params[:name], :created_at => DateTime.now.to_date, :updated_at => DateTime.now.to_date)
    if @category.save
      #@course.logo.attach(io: StringIO.new('https://saberes.senado.leg.br/images/logo_saberes_xl.png'), filename: 'logo_saberes.png', content_type: 'image/png')
      render status: 200, json: {
          message: "Categoria criada com sucesso",
      }.to_json
    else
      render status: 400, json: {
          message: "Não foi possível criar categoria",
      }.to_json
    end
  end

  def atualizar_categoria
    if params[:id].present?
      @category = CourseCategory.find_by(id: params[:id])
      @category.update(name: params[:name])
    end
    #verificar presença de imagem
    render status: 200, json: {
        message: "Categoria atualizada com sucesso",
    }.to_json
  end

  def index
    categories = CourseCategory.all
    hash_categories = categories.map do |c|
      {'id' => c.id,
       'nome' => c.name,
       'logo' => if c.logo.attached?
                   url_for(c.logo)
                 else
                   ''
                 end
      }
    end
    render status: 200, json: {
        categorias_cursos: hash_categories,
    }.to_json
  end

  private

  def course_category_params
    params.require(:course_category).permit(:name)
  end
end
