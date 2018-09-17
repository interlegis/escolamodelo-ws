class CoursesController < ApplicationController
  skip_before_action :verify_authenticity_token
  #Adicionar token para que apenas acesso permitido possa acessar os métodos
  # Acrescentar mensagens de erro
  # Corrigir school_id
  def adicionar_curso
    @course = Course.new(course_params)
    if @course.save
    #@course.logo.attach(io: StringIO.new('https://saberes.senado.leg.br/images/logo_saberes_xl.png'), filename: 'logo_saberes.png', content_type: 'image/png')
      render status: 200, json: {
          message: "Curso criado com sucesso",
      }.to_json
    else
      render status: 400, json: {
          message: "Não foi possível criar curso",
      }.to_json
    end

  end
  def atualizar_curso
    @course = Course.find_by(ead_id: course_params[:ead_id], school_id: course_params[:school_id])
    @course.update(course_params)
    #Verificar presença de imagem da logo
    render status: 200, json: {
        message: "Curso atualizado com sucesso",
    }.to_json
  end
  def index
    courses = Course.all
    hash_courses = courses.map do |c|
      [Hash['id',c.id],
       Hash['nome',c.name],
       Hash['logo',if c.logo.attached?
                     root_url[0..-2] + rails_blob_path(c.logo, disposition: "attachment")
                   else
                     ''
                   end
       ],
       Hash['categoria',
            [Hash['nome',c.course_category.name],
             Hash['logo',
                  if c.course_category.logo.attached?
                    root_url[0..-2] + rails_blob_path(c.course_category.logo, disposition: "attachment")
                  else
                    ''
                  end
             ]
            ]
       ]
      ]
    end
    render status: 200, json: {
        cursos: hash_courses,
    }.to_json
  end


  private
  def course_params
    params.require(:course).permit(:name, :course_category_id, :url, :school_id, :course_load, :description, :ead_id)
  end
end