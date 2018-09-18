class CertificatesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def adicionar_certificado
    certificates=params[:certificates]
    school=School.find_by(initials: params[:school])
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
      #@course.logo.attach(io: StringIO.new('https://saberes.senado.leg.br/images/logo_saberes_xl.png'), filename: 'logo_saberes.png', content_type: 'image/png')
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
  def certificado_usuario #Depois adicionar link do certificado
    certificate = Certificate.find_by(code_id: params[:code]) #talvez incluir outro parâmetro na busca para o caso de código repetido entre moodles
    if certificate.present?
      hash_certificate = [Hash['id',c.id], Hash['data de emissão',c.issue_date]]
      render status: 200, json: {
          certificados: hash_certificate,
      }.to_json
    else
      render status: 400, json: {
          message: "Certificado não encontrado"
      }.to_json
    end
  end
end