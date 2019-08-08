class CourseRegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  #before_action :user_data_access

  def new
    if params[:id].present?
      @course = Course.find(params[:id])
    else
      school = School.find_by(initials: params[:school])
      if school.present?
        @course = Course.find_by(school_id: school.id, ead_id: params[:school_course])
      else
        @course = nil
      end
    end
    if @course.present?
      @redirect = params[:redirect]
      @quiz = Quiz.order(:id).last
      @quiz_questions = @quiz.quiz_questions
    else
      redirect_to user_path
    end
  end

  # def preencher_quiz
  #   course = Course.find(params[:registration][:course_id]) #Adicionar verificação de que esse curso pode receber a inscrição e se já não está matriculado
  #   registration = CourseRegistration.find_by(user_id: current_user.id, course_id: course.id)    
  #   params[:registration].each do |key, value| #Pode ser necessária uma verificação de que as perguntas foram respondidas
  #     UserQuizAnswer.create(quiz_answer_id: value, course_registration_id: registration.id)
  #   end
  #   redirect_to params[:registration][:redirect] #Redirecionar para alguma mensagem depois        
  # end

  def create
    course = Course.find(params[:registration][:course_id]) #Adicionar verificação de que esse curso pode receber a inscrição e se já não está matriculado
    if course.present?
      user_id = current_user ? current_user.id : params[:user_id]
      registration = CourseRegistration.find_by(user_id: user_id, course_id: course.id)
      if registration.present? #Verifica se já está matriculado
        redirect_to user_path #Redirecionar para alguma mensagem depois
      else
        # registration = CourseRegistration.new(user_id: current_user.id, course_id: course.id, course_registration_status_id: 2)
        registration = CourseRegistration.new(user_id: user_id, course_id: course.id, course_registration_status_id: 2)
        if registration.save
          params[:registration].each do |key, value| #Pode ser necessária uma verificação de que as perguntas foram respondidas
            UserQuizAnswer.create(quiz_answer_id: value, course_registration_id: registration.id)

          end
        end
        redirect_to params[:registration][:redirect]
      end
    else
      render 'new' #Aqui precisa redirecionar para outro lugar por não ter encontrado o curso
    end
  end

  def matricula_alunos
    # matriculas = CourseRegistration.select('id', 'user_id').where(:course_id=> params[:course])
    school = School.find_by(initials: params[:sigla])
    course = Course.find_by(ead_id: params[:course], school: school.id)
    params[:alunos].each do |aluno|
      user = User.find_by(cpf: aluno)
      registration = CourseRegistration.new(user_id: user.id, course_id: course.id, course_registration_status_id: 2)
      if registration.save
        render status: 200, json: {
            mensagem: "Usuário " + user.first_name + " " + user.last_name + " foi matriculado no curso " + params[:course] + "\n",
        }.to_json
      else
        render status: 400, json: {
            mensagem: 'Ocorreu um erro, não foi possível matricular o aluno ' + user.first_name + " " + user.last_name + "\n",
        }.to_json
      end
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

  def consulta_quiz
    user = User.find_by(cpf: params[:user])
    if user.present?
      school = School.find_by(initials: params[:school])
      if school.present?
        @course = Course.find_by(school_id: school.id, ead_id: params[:school_course])
        if @course.present?
          registration = CourseRegistration.find_by(user_id: user.id, course_id: @course.id)
          if registration.present?
            quiz = UserQuizAnswer.find_by(course_registration_id: registration.id)
            if quiz.present?
              return render status: 200, json: {
                  result: true,
              }.to_json
            end
          end
        end
      end
    end
    return render status: 200, json: {
        result: false,
    }.to_json
  end

  def confirmacao_matricula
    school = School.find_by(initials: params[:school])
    if school
      course = Course.find_by(school_id: school.id, ead_id: params[:course])
      if course
        api_key = ApiAccess.find_by(key: params[:key])
        course_registration = CourseRegistration.find_by(course_id: course.id, user_id: api_key.user_id)
        if course_registration
          render status: 200, json: {
              situacao: course_registration.course_registration_status.status,
          }.to_json
        else
          render status: 200, json: {
              situacao: 'Não registrado',
          }.to_json
        end
      else
        render status: 400, json: {
            mensagem: 'Curso não encontrado',
        }.to_json
      end
    else
      render status: 400, json: {
          mensagem: 'Escola não encontrada',
      }.to_json
    end

  end
end
