class ContactUsConversationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    conversations = ContactUsConversation.all
    puts conversations
    render json:conversations
  end

  def mensagens
    @conversation = ContactUsConversation.where(id: params[:conversation_id]).first
    if @conversation.present?
      messages = @conversation.contact_us_message.order(:created_at)
      hash_answer_school = messages.map do |c|
        {
          'id' => c.id,
          'description' => c.description,
          'cpf' => c.cpf,
          'email' => c.email,
          'date' => c.created_at,
          'was_answered' => c.was_answered
        }
      end
      if messages.empty?
        render status: 400, json: {
          message: "Conversa não iniciada iniciada."
        }.to_json
      else
        render json:hash_answer_school
      end
    else
      render status: 400, json: {
        message: "Conversa não encontrada"
      }.to_json
    end
  end

  def apagar_conversa
    @conversation = ContactUsConversation.where(id: params[:conversation_id]).first
    if @conversation.present?
      @conversation.destroy
      render json:@conversation
    else
      render status: 400, json: {
        message: "Conversa não encontrada"
      }.to_json
    end
  end
end
