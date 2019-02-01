class SchoolsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def registrar_escola
    @api_key = ApiAccess.find_by(key: params[:key])
    if @api_key.present?
      if @api_key.api_access_level_id == 4
        @school = School.find_by(initials: params[:initials])
        if @school.present?
          if @school.update(url: params[:url], name: params[:name])
            if params[:logo].present?
              require 'open-uri'
              @school.logo.attach(io: open(params[:logo]), filename: @school.name.downcase)
            end
            render status: 200, json: {
                message: "Escola atualizada com sucesso",
            }.to_json
          else
            render status: 400, json: {
                message: "Não foi possível atualizar a escola",
            }.to_json
          end
        else
          @school = School.new(url: params[:url], name: params[:name], initials: params[:initials])
          if @school.save
            if params[:logo].present?
              require 'open-uri'
              @school.logo.attach(io: open(params[:logo]), filename: @school.name.downcase)
            end
            render status: 200, json: {
                message: "Escola criada com sucesso",
            }.to_json
          else
            render status: 400, json: {
                message: "Não foi possível criar escola",
            }.to_json
          end
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
