class ContactUsMessagesController < ApplicationController
  require 'date'
  skip_before_action :verify_authenticity_token

  def index
    messages = ContactUsMessage.all
    render json:messages
  end

  def mensagem_escola
    messages = ContactUsMessage.all
    messages_school = []
    for message in messages
      if message.school_initials == params[:school_initial]
        messages_school.push(message)
      end
    end
    if messages_school.empty?
      render json: "Nao existe mensagens para esta escola", status: 200
    else
      render json:messages_school
    end
  end

  def adicionar_mensagem
    @mensagem = ContactUsMessage.new(contact_us_params)
    puts @mensagem.name
    puts contact_us_params
    # @mesagem.date = "09/05/1995"
    if @mensagem.save
      # render json: "Mensagem enviada com sucesso", status: :created
      render status: 200, json: {
        message: "Mensagem enviada com sucesso",
      }.to_json
    else
      render status: 400, json: {
        message: "Ocorreu um erro"
      }.to_json
    end
  end

  private
  def contact_us_params
    params.permit(:name, :email, :cpf, :description, :date, :school_id, :course_category_id, :course_id)
  end
end
