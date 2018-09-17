class CertificatesController < ApplicationController
  def adicionar_certificado
    school=School.find_by(initials: params[:school])
    course=Course.find_by('ead_id = ? and school_id = ?', params[:certificate][:course], school.id)
    user=User.find_by(cpf: params[:certificate][:course]) #Atualmente cpf tem q ter . e -
    Certificate.new(course_id: course, user_id: user, issue_date: params[:certificate][:date], grade: params[:certificate][:grade], code_id: params[:certificate][:code])
  end
end