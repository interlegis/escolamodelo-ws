class SchoolsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def adicionar_escola
    @school = School.new(course_category_params)
    @school.save
    #@course.logo.attach(io: StringIO.new('https://saberes.senado.leg.br/images/logo_saberes_xl.png'), filename: 'logo_saberes.png', content_type: 'image/png')
    render status: 200, json: {
        message: "Escola criada com sucesso",
    }.to_json
  end
  def atualizar_escola
    school_name=school_params[:name].split.map(&:capitalize).join(' ') if school_params[:name].present?
    @school = School.find_by(name: school_name) #Talvez outro parâmetro para encontrar a escola seja melhor
    @school.update(school_params)
    #verificar presença de imagem
    render status: 200, json: {
        message: "Escola atualizada com sucesso",
    }.to_json
  end
  def index
    schools = School.all
    hash_schools = schools.map do |c|
      [Hash['nome',c.name],
       Hash['logo',if c.logo.attached?
                     root_url[0..-2] + rails_blob_path(c.logo, disposition: "attachment")
                   else
                     ''
                   end
       ],
       Hash['url',c.url]
      ]
    end
    render status: 200, json: {
        escolas: hash_schools,
    }.to_json
  end
  private
  def school_params
    params.require(:school).permit(:name, :url)
  end
end
