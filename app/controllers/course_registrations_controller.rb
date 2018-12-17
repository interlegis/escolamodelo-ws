class CourseRegistrationsController < ApplicationController
  def new
    if current_user
      if !current_user.restriction
        @quiz = Quiz.order(:id).last
        @quiz_questions = @quiz.quiz_questions
      else
        redirect_to user_path
      end
    else
      redirect_to log_in_path
    end
  end

  def create
    course = Course.find(params[:id])
    if course.present?
      registration = CourseRegistration.new(user_id: current_user.id, course_id: course.id, course_registration_status_id: 2)
      if registration.save
        print('cheguei aqui')
        print(params[:registration])
        params[:registration].each do |key, value|
          UserQuizAnswer.create(quiz_answer_id: value, course_registration_id: registration.id)
        end
      end
    else
      render 'new'
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
          school = School.find(course.school_id)
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
