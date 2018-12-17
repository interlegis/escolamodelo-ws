class CourseCategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def adicionar_categoria
    @api_key = ApiAccess.find_by(key: params[:key])
    if @api_key.present?
      if @api_key.api_access_level_id == 4
        @category = CourseCategory.new(course_category_params)
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
      else
        render status: 400, json: {
            message: "Permissão negada",
        }.to_json
      end
    else
      render status: 400, json: {
          message: "Chave não encontrada",
      }.to_json
    end
  end

  def atualizar_categoria
    @api_key = ApiAccess.find_by(key: params[:key])
    if @api_key.present?
      if @api_key.api_access_level_id == 4
        nome_cat = course_category_params[:name].split.map(&:capitalize).join(' ') if course_category_params[:name].present?
        @category = CourseCategory.find_by(name: nome_cat)
        @category.update(course_category_params)
        #verificar presença de imagem
        render status: 200, json: {
            message: "Categoria atualizada com sucesso",
        }.to_json
      else
        render status: 400, json: {
            message: "Permissão negada",
        }.to_json
      end
    else
      render status: 400, json: {
          message: "Chave não encontrada",
      }.to_json
    end
  end

  def index
    @api_key = ApiAccess.find_by(key: params[:key])
    if @api_key.present?
      if @api_key.api_access_level_id >= 3
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
      else
        render status: 400, json: {
            message: "Permissão negada",
        }.to_json
      end
    else
      render status: 400, json: {
          message: "Chave não encontrada",
      }.to_json
    end
  end

  private

  def course_category_params
    params.require(:course_category).permit(:name)
  end
end
