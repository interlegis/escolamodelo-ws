class CoursesController < ApplicationController
  skip_before_action :verify_authenticity_token
  # Acrescentar mensagens de erro

  def registrar_curso
    @api_key = ApiAccess.find_by(key: params[:key])
    if @api_key.present?
      if @api_key.api_access_level_id == 4
        school = School.find_by(initials: params[:school])
        if school.present?
          @course = Course.find_by(ead_id: course_params[:ead_id], school_id: school.id)
          if @course #Verifica se o curso existe
            if @course.update(course_params)
              if params[:course][:logo].present?
                require 'open-uri'
                @course.logo.purge
                @course.logo.attach(io: open(params[:course][:logo]), filename: @course.name.downcase)
              end
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
              if params[:course][:logo].present?
                require 'open-uri'
                @course.logo.attach(io: open(params[:course][:logo]), filename: @course.name.downcase)
              end
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
      if @course.save
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

  def buscar_cursos
    school = School.find_by(initials: params[:school])
    puts school
    courses = Course.where('(lower(name) LIKE ? OR lower(description) LIKE ?) AND school_id != ?', "%#{params[:expression].downcase}%", "%#{params[:expression].downcase}%", school.id)
    if courses.present?
      hash_courses = courses.map do |c|
        {'name' => c.name,
         'description' => c.description,
         'url' => if c.url?
                    c.url
                  else
                    c.school.url +  "/course/view.php?id=" + c.ead_id.to_s
                  end,
        }
      end
      render status: 200, json: {
          cursos: hash_courses,
      }.to_json
    else
      render status: 400, json: {
          cursos: "",
      }.to_json
    end
  end

  def index_cursos_pendentes
    courses = Course.where(status: "Pendente", visible: 'true')
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
    @api_key = ApiAccess.find_by(key: params[:key])
    if @api_key.present?
      if @api_key.api_access_level_id >= 3
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

  def course_params
    params.require(:course).permit(:name, :url, :course_load, :description, :ead_id, :conteudista, :certificador, :carga_horaria, :visible)
  end
end
