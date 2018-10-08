class ContactUsMessagesController < ApplicationController
  require 'date'
  skip_before_action :verify_authenticity_token

  def index
    messages = ContactUsMessage.all
    render json:messages
  end

  def apagar_mensagem
    @message = ContactUsMessage.where(id: params[:message_id]).first
    if @message.present?
      if @message.destroy
        render status: 400, json: {
          message: "Mensagem foi apagada com sucesso"
        }.to_json
      else
        render status: 400, json: {
          message: "Ocorreu um erro"
        }.to_json
      end
    else
      render status: 400, json: {
        message: "Mensagem não foi encontrada"
      }.to_json
    end
  end

  def atualizar_mensagem
    @message = ContactUsMessage.where(id: params[:message_id]).first
    if @message.update(contact_us_message_params)
      render status: 200, json: {
        message: "Mensagem atualizada com sucesso",
      }.to_json
    else
      render status: 400, json: {
        message: "Ocorreu um erro"
      }.to_json
    end
  end

  private
  def contact_us_message_params
    params.permit(:user_id, :cpf, :name, :email, :description, :is_student)
  end
end
