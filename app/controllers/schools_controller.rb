class SchoolsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :admin_access, only: [:registrar_escola]
  before_action :basic_api_access, only: [:index]

  def registrar_escola
    @school = School.find_by(initials: params[:initials])
    if @school.present?
      if @school.update(url: params[:url], name: params[:name])
        if params[:logo].present?
          begin
            require 'open-uri'
            @school.logo.attach(io: open(URI::encode(params[:logo])), filename: @school.name.downcase)
            render status: 200, json: {
                message: "Escola atualizada com sucesso",
            }.to_json
          rescue => ex
            logger.error ex.message
            render status: 400, json: {
                message: "Não foi possível atualizar a logo da escola",
            }.to_json
          end
        else
          render status: 200, json: {
              message: "Escola atualizada com sucesso",
          }.to_json
        end
      else
        render status: 400, json: {
            message: "Não foi possível atualizar a escola",
        }.to_json
      end
    else
      @school = School.new(url: params[:url], name: params[:name], initials: params[:initials])
      if @school.save
        if params[:logo].present?
          begin
            require 'open-uri'
            @school.logo.attach(io: open(URI::encode(params[:logo])), filename: @school.name.downcase)
            render status: 200, json: {
                message: "Escola criada com sucesso",
            }.to_json
          rescue => ex
            logger.error ex.message
            render status: 400, json: {
                message: "Não foi possível criar a logo da escola",
            }.to_json
          end
        else
          render status: 200, json: {
              message: "Escola criada com sucesso",
          }.to_json
        end
      else
        render status: 400, json: {
            message: "Não foi possível criar escola",
        }.to_json
      end
    end
  end

  def index
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
  end

  private

  def school_params
    params.require(:school).permit(:name, :url, :initials)
  end
end
