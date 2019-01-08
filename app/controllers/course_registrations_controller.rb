class CourseRegistrationsController < ApplicationController
  def new
    if current_user
      if !current_user.restriction
        if params[:id].present?
          @course = Course.find(params[:id])
        else
          @course = Course.find_by(school_id: params[:school], ead_id: params[:school_course])
        end
        if @course.present?
          @redirect = params[:redirect]
          @quiz = Quiz.order(:id).last
          @quiz_questions = @quiz.quiz_questions
        else
          redirect_to user_path #Alterar esse redirect para outra coisa depois
        end
      else
        redirect_to user_path
      end
    else
      redirect_to log_in_path(return: registro_curso_path(id: params[:id],
                                                             school_id: params[:school],
                                                             school_course: params[:school_course],
                                                             redirect: params[:redirect]))
    end
  end

  def create
    course = Course.find(params[:registration][:course_id]) #Adicionar verificação de que esse curso pode receber a inscrição e se já não está matriculado
    if course.present?
      registration = CourseRegistration.find_by(user_id: current_user.id, course_id: course.id)
      if registration.present? #Verifica se já está matriculado
        redirect_to user_path #Redirecionar para alguma mensagem depois
      else
        registration = CourseRegistration.new(user_id: current_user.id, course_id: course.id, course_registration_status_id: 2)
        if registration.save
          print(params[:registration])
          params[:registration].each do |key, value| #Pode ser necessária uma verificação de que as perguntas foram respondidas
            UserQuizAnswer.create(quiz_answer_id: value, course_registration_id: registration.id)
          end
          redirect_to params[:registration][:redirect]
        end
      end
    else
      render 'new' #Aqui precisa redirecionar para outro lugar por não ter encontrado o curso
    end
  end

  def cursos_usuario
    api_key = ApiAccess.find_by(key: params[:key])
    if api_key.present?
      if api_key.api_access_level_id >= 3 #Confirmar se BasicApiControl é suficiente para buscar cursos de qualquer usuário
        user = User.find_by(cpf: params[:cpf])
      elsif api_key.api_access_level_id == 2 #retornar os dados do próprio usuário se a permissão for insuficiente
        user = api_key.user
      else
        render status: 400, json: {
            erro: 'Usuário não completou os dados ainda'
        }.to_json
      end
      if user.present?
        course_registrations = user.course_registrations
        hash_courses = course_registrations.map do |c|
          course = Course.find(c.course_id)
          school = course.school
          {'id' => c.id,
           'course' => {
               'id' => c.course.id,
               'nome' => c.course.name
           },
           'registration_status' => {
               'id' => c.course_registration_status.id,
               'status' => c.course_registration_status.status
           },
           'school' => {
               'url' => school.url
           }
          }
        end
        render status: 200, json: {
            cursos_usuario: hash_courses,
        }.to_json
      else
        render status: 400, json: {
            erro: 'Usuário não encontrado'
        }.to_json
      end
    else
      render status: 400, json: {
          erro: 'Chave não encontrada'
      }.to_json
    end
  end
end
