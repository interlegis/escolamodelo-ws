class CertificatesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def adicionar_certificado
    certificates=params[:certificates]
    school=School.find_by(initials: params[:school]) #adicionar render em caso de não encontrar escola
    error=[]
    certificates.each do |certificate|
      course=Course.find_by('ead_id = ? and school_id = ?', certificate[:course], school.id)
      time=DateTime.strptime(certificate[:date], '%s')
      user=User.find_by(cpf: certificate[:student])
      c=Certificate.new(course_id: course.id, user_id: user.id, issue_date: time, grade: certificate[:grade], code_id: certificate[:code])
      if !c.save
        error.push(c.code_id)
      end
    end
    if error.length == 0
      render status: 200, json: {
          message: "Certificados salvos com sucesso",
      }.to_json
    else
      render status: 400, json: {
          message: "Não foi possível salvar algum certificado",
          school: school.name,
          codes_id: error
      }.to_json
    end
  end
  def certificado_usuario
    user = User.find_by(cpf: params[:cpf])
    if user.present?
      hash_certificates=user.certificates.map do |certificate|
        {'id' => certificate.id,
         'data de emissão' => certificate.issue_date,
         'url' => certificate.course.school.url+ '/blocks/get_certificate/review.php?code=' + certificate.code_id + '&user=' + user.cpf
        }
      end
      render status: 200, json: {
          certificados: hash_certificates,
      }.to_json
    else
      render status: 400, json: {
          message: "Usuário não encontrado ou CPF incorreto"
      }.to_json
    end
  end
end