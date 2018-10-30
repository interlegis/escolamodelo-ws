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
        params[:registration].each do |key,value|
          UserQuizAnswer.create(quiz_answer_id: value, course_registration_id: registration.id)
        end
      end
    else
      render 'new'
    end
  end

  def cursos_usuario
    course_registrations = User.courses_registrations
    hash_courses = course_registrations.map do |c|
      {'id' => c.id,
       'course' => {
           'id' => c.course.id,
           'nome' => c.course.name
       },
       'registration_status' => {
           'id' => c.course_registration_status.id,
           'status' => c.course_registration_status.status
       }
      }
    end
    render status: 200, json: {
        cursos_usuario: hash_courses,
    }.to_json
  end
end
