class CertificatesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :admin_access, only: [:adicionar_certificado]

  def adicionar_certificado
    certificates=params[:certificates]
    school=School.find_by(initials: params[:school]) #adicionar render em caso de não encontrar escola
    error=[]
    certificates.each do |certificate|
      course=Course.find_by('ead_id = ? and school_id = ?', certificate[:course], school.id)
      time=Time.at(certificate[:date].to_i)
      # if certificate[:student]!="admin"
      user=User.find_by(cpf: certificate[:student])
      # else 
      #   render status: 400, json: {
      #     message: "Não foi possível salvar algum certificado",
      #     school: school.name,
      #     codes_id: error
      #   }.to_json
      # end
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
    cpf = user_data_access
    user = User.find_by_cpf(cpf)
    if user.present?
      hash_certificates=user.certificates.map do |certificate|
        {'id' => certificate.id,
         'data_de_emissao' => certificate.issue_date.strftime("%d-%m-%Y"),
         'url' => certificate.course.school.url+ '/blocks/get_certificate/review.php?code=' + certificate.code_id + '&user=' + user.cpf,
         'nota' => certificate.grade,
         'curso' => certificate.course.name,
         'escola' => certificate.course.school.name,
         'code_id' => certificate.code_id
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
  def detalhes_certificado
    certificado = Certificate.find_by(code_id: params[:code_id])
    if certificado.present?
      escola = School.find_by(id: certificado.course.school_id)
      certificado_json = {
        'nome_aluno' => certificado.user.first_name + " " + certificado.user.last_name,
        'cpf' => certificado.user.cpf,
        'curso' => certificado.course.name,
        'duracao' => certificado.course.carga_horaria,
        'escola' => escola.name,
        'nota' => certificado.grade
      }
      render status: 200, json:{
        certificado: certificado_json,
      }.to_json
    else
      render status: 400, json: {
          message: "Certificado não encontrado"
      }.to_json
    end
  end
end
