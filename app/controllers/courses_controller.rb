class CoursesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :basic_api_access, only: [:index, :registrar_curso, :aprovar_curso, :index_cursos_pendentes]
  # Acrescentar mensagens de erro

  def registrar_curso
    category = CourseCategory.find_by('lower(name) = lower(?) or id = ?', params[:course][:category], params[:course][:category].to_i)
      @course = Course.find_by(ead_id: course_params[:ead_id], school_id: @school.id)
      if @course #Verifica se o curso existe
        @course.course_category_id = category.id if category.present?
        if @course.update(course_params)
          if params[:course][:logo].present?
            begin
              require 'open-uri'
              @course.logo.attach(io: open(URI::encode(params[:course][:logo])), filename: @course.name.downcase)
              render status: 200, json: {
                  message: "Curso atualizado com sucesso",
              }.to_json
            rescue => ex
              logger.error ex.message
              render status: 400, json: {
                  message: "Não foi possível atualizar a logo do curso",
              }.to_json
            end
          else
            render status: 200, json: {
                message: "Curso atualizado com sucesso",
            }.to_json
          end
        else
          render status: 400, json: {
              message: "Não foi possível atualizar curso",
          }.to_json
        end
      elsif category.present?
        @course = Course.new(course_params)
        @course.school_id = @school.id
        @course.course_category_id = category.id
        @course.status = "Aprovado"
        if @course.save
          if params[:course][:logo].present?
            begin
              require 'open-uri'
              @course.logo.attach(io: open(URI::encode(params[:course][:logo])), filename: @course.name.downcase)
              render status: 200, json: {
                  message: "Curso criado com sucesso",
              }.to_json
            rescue => ex
              logger.error ex.message
              render status: 400, json: {
                  message: "Não foi possível criar a logo do curso",
              }.to_json
            end
          else
            render status: 200, json: {
                message: "Curso criado com sucesso",
            }.to_json
          end
        else
          render status: 400, json: {
              message: "Não foi possível criar curso",
          }.to_json
        end
      else
        render status: 400, json: {
            message: "Categoria ausente ao criar curso",
        }.to_json
      end
  end

  def aprovar_curso
    if params[:status].capitalize != "Aprovado" && params[:status].capitalize != "Reprovado" && params[:status].capitalize != "Pendente"
      render status: 400, json: {
          message: "Estado inválido",
      }.to_json
    elsif params[:category].blank? && params[:status].capitalize == "Aprovado"
      render status: 400, json: {
          message: "Categoria não informada",
      }.to_json
    else
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
    courses = Course.where('(lower(name) LIKE ? OR lower(description) LIKE ?) AND school_id != ?', "%#{params[:expression].downcase}%", "%#{params[:expression].downcase}%", @school.id)
    if courses.present?
      hash_courses = courses.map do |c|
        {'name' => c.name,
         'description' => c.description,
         'url' => if c.url?
                    c.url
                  else
                    c.school.url + "/course/view.php?id=" + c.ead_id.to_s
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
         'school' => c.school.initials,
         'school_url' => c.school.url,
         'url' => if c.url?
                    c.url
                  else
                    c.school.url + "/course/view.php?id=" + c.ead_id.to_s
                  end,
         'visible' => c.visible,
        }
      end
      print(hash_courses)
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
       'rating' => c.course_rating.average(:rating),
       'url' => if c.url?
                  c.url
                else
                  c.school.url + "/course/view.php?id=" + c.ead_id.to_s
                end,
       'rating_percentage' =>
           if c.course_rating.average(:rating)
             (c.course_rating.average(:rating) / 5 * 100).round(1).to_s
           else
             nil
           end,
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
