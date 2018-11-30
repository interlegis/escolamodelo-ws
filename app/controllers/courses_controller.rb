class CoursesController < ApplicationController
  skip_before_action :verify_authenticity_token
  #Adicionar token para que apenas acesso permitido possa acessar os métodos
  # Acrescentar mensagens de erro

  def registrar_curso
    school = School.find_by(initials: params[:school])
    if school.present?
      @course = Course.find_by(ead_id: course_params[:ead_id], school_id: school.id)
      if @course #Verifica se o curso existe
        if @course.update(course_params)
          #Verificar presença de imagem da logo
          render status: 200, json: {
              message: "Curso atualizado com sucesso",
          }.to_json
        else
          render status: 400, json: {
              message: "Não foi possível atualizar curso",
          }.to_json
        end
      else
        @course = Course.new(course_params)
        @course.school_id = school.id
        @course.status = "Pendente"
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
    else
      render status: 404, json: {
        message: "Escola não encontrada",
      }.to_json
    end
  end

  def avaliar_curso
    if params[:status].capitalize != "Aprovado" && params[:status].capitalize != "Reprovado" && params[:status].capitalize != "Pendente"
      render status: 400, json: {
          message: "Estado inválido",
      }.to_json
    elsif params[:category].blank? && params[:status].capitalize == "Aprovado"
      render status: 400, json: {
          message: "Categoria não informada",
      }.to_json
    else
      school = School.find_by(initials: params[:school])
      @course = Course.find_by(id: params[:id])
      @course.status = params[:status].capitalize
      if params[:status].capitalize == "Aprovado"
        category = CourseCategory.find(params[:category])
        @course.course_category_id = category.id
      end
      if @course.save()
        render status: 200, json: {
            message: "O estado do curso foi alterado com sucesso",
        }.to_json
      else
        render status: 400, json: {
            message: "Não foi possível alterar o estado do curso",
        }.to_json
      end
    end
  end

  def index_cursos_pendentes
    courses = Course.all.where(status: "Pendente", visible: 'true')
    if courses.present?
      hash_courses = courses.map do |c|
        {'id' => c.id,
        'ead_id' => c.ead_id,
        'nome' => c.name,
         'logo' => if c.logo.attached?
                     url_for(c.logo)
                   else
                     ''
                   end,
         'descricao' => c.description,
         'certificador' => c.certificador,
         'conteudista' => c.conteudista,
         'carga_horaria' => c.carga_horaria,
         'iniciais_escola' => c.school.initials,
         'status' => c.status,
         'visible' => c.visible
        }
      end
      render status: 200, json: {
          cursos: hash_courses,
      }.to_json
    else
      render status: 400, json: {
          message: "Não existe cursos pendentes",
      }.to_json
    end
  end

  def index
    courses = Course.all.where.not(status: ['Pendente', 'Reprovado'], visible: 'false')
    hash_courses = courses.map do |c|
      {'id' => c.id,
      'ead_id' => c.ead_id,
      'nome' => c.name,
       'logo' => if c.logo.attached?
                   url_for(c.logo)
                 else
                   ''
                 end,
       'descricao' => c.description,
       'categoria' => c.course_category_id,
       'certificador' => c.certificador,
       'conteudista' => c.conteudista,
       'carga_horaria' => c.carga_horaria,
       'iniciais_escola' => c.school.initials,
       'status' => c.status,
       'visible' => c.visible,
      }
    end
    render status: 200, json: {
        cursos: hash_courses,
    }.to_json
  end


  private
  def course_params
    params.require(:course).permit(:name, :url, :course_load, :description, :ead_id, :conteudista, :certificador, :carga_horaria, :visible)
  end
end
