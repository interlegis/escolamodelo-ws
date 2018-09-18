class SchoolsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def adicionar_escola
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
  end
  def atualizar_escola
    @school = School.find_by(initials: params[:school][:initials])
    @school.update(school_params)
    #verificar presença de imagem
    render status: 200, json: {
        message: "Escola atualizada com sucesso",
    }.to_json
  end
  def index
    schools = School.all
    hash_schools = schools.map do |c|
      {'id' => c.id,
       'nome' => c.name,
       'logo' => if c.logo.attached?
                   root_url[0..-2] + rails_blob_path(c.logo, disposition: "attachment")
                 else
                   ''
                 end,
       'url' => c.url
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
