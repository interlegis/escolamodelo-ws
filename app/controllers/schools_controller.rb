class SchoolsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def adicionar_escola
    @api_key = ApiAccess.find_by(key: params[:key])
    if @api_key.present?
      if @api_key.api_access_level_id == 4
        @school = School.new(school_params)
        if @school.save
          #@course.logo.attach(io: StringIO.new('https://saberes.senado.leg.br/images/logo_saberes_xl.png'), filename: 'logo_saberes.png', content_type: 'image/png')
          render status: 200, json: {
              message: "Escola criada com sucesso",
          }.to_json
        else
          render status: 400, json: {
              message: "Não foi possível criar escola",
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

  def atualizar_escola
    @api_key = ApiAccess.find_by(key: params[:key])
    if @api_key.present?
      if @api_key.api_access_level_id == 4
        @school = School.find_by(initials: params[:initials_school])
        if !params[:school][:initials].present?
          params[:school][:initials] = @school.initials
        end
        @school.update(school_params)
        #verificar presença de imagem
        render status: 200, json: {
            message: "Escola atualizada com sucesso",
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
        schools = School.all
        hash_schools = schools.map do |c|
          {'id' => c.id,
           'nome' => c.name,
           'logo' => if c.logo.attached?
                       url_for(c.logo)
                     else
                       ''
                     end,
           'url' => c.url,
           'initials' => c.initials
          }
        end
        render status: 200, json: {
            escolas: hash_schools,
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

  def school_params
    params.require(:school).permit(:name, :url, :initials)
  end
end
