class ContactUsConversationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:school_initials].present?
      if params[:was_answered] == true
        conversations = ContactUsConversation.all.where(school_initials: params[:school_initials], was_answered: true).order("updated_at")
      else
        conversations = ContactUsConversation.all.where(school_initials: params[:school_initials], was_answered: false).order("created_at")
      end
      if params[:limit].present?
        hash_conversation = conversations.page(params[:page]).per(params[:limit]).map do |c|
          {
            'id_conversa' => c.id,
            'titulo' => c.title,
            'cpf' => c.cpf,
            'data_mensagem' => c.created_at.to_date,
            'situacao' => c.was_answered
          }
        end
        render json:hash_conversation, status: 200, quantidade_mensagem: conversations.size
      else
        hash_conversation = conversations.page(params[:page]).map do |c|
          {
            'id_conversa' => c.id,
            'titulo' => c.title,
            'cpf' => c.cpf,
            'data_mensagem' => c.created_at.to_date,
            'situacao' => c.was_answered
          }
        end
        render json:hash_conversation, status: 200, quantidade_mensagem: conversations.size
      end
    else
      render status: 400, json: {
        message: "Identifique a escola"
      }.to_json
    end
  end

  def conversa_usuario
    user = User.find_by(cpf: params[:cpf])
    @conversation = user.contact_us_conversations.all
    hash_conversation_user = @conversation.map do |c|
      {
        'id_conversa' => c.id,
        'titulo' => c.title,
        'cpf' => c.cpf,
        'data_mensagem' => c.created_at,
        'situacao' => c.was_answered
      }
    end
    if @conversation.empty?
      render status: 400, json: {
        message: "Não existem conversas."
      }.to_json
    else
      render json:hash_conversation_user
    end
    rescue StandardError => e
      render status: 400, json: {
        message: "Não existe usuário com este cpf."
      }.to_json
  end

  def adicionar_conversa
    if params[:conversation_id].present? # Se a conversa já existir
      @conversation = ContactUsConversation.find(params[:conversation_id])
      if params[:is_student] != false
        puts params[:is_student]
        @conversation.update(:was_answered => false)
      else
        @conversation.update(:was_answered => true)
      end
    else # Conversa ainda não existe
      user=User.find_by(cpf: params[:cpf])
      if params[:school_initials].present? == true
        @conversation = user.contact_us_conversations.create(contact_us_conversation_params.merge(was_answered: false))
      else
        return render status: 400, json: {
          message: "Ocorreu um erro! Conversa ou escola não identificada."
        }.to_json
      end
    end
    @conversation.contact_us_message.create(contact_us_message_params)
    if @conversation.save
      render status: 200, json: {
        message: "Conversa criada com sucesso",
      }.to_json
    else
      render status: 400, json: {
        message: "Ocorreu um erro"
      }.to_json
    end
    rescue StandardError => e
      render status: 400, json: {
        message: "Não existe usuário com este cpf."
      }.to_json
  end

  def detalhar_conversa
    @conversation = ContactUsConversation.where(id: params[:conversation_id]).first
    if @conversation.present?
      messages = @conversation.contact_us_message.all.order(:created_at)
      hash_messages_school = messages.map do |c|
        {
          'data_mensagem' => c.created_at,
          'cpf' => c.cpf,
          'aluno' => c.is_student,
          'texto_mensagem' => c.description
        }
      end
      if messages.empty?
        render status: 400, json: {
          message: "Não existem mensagens nessa conversa."
        }.to_json
      else
        render json:hash_messages_school
      end
    else
      render status: 400, json: {
        message: "Conversa não encontrada."
      }.to_json
    end
  end

  def atualizar_conversa
    @conversation = ContactUsConversation.where(id: params[:conversation_id]).first
    if @conversation.update(contact_us_conversation_params)
      render status: 200, json: {
        message: "Conversa atualizada com sucesso",
      }.to_json
    else
      render status: 400, json: {
        message: "Ocorreu um erro"
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

  private
  def contact_us_conversation_params
    params.permit(:type_conversation, :title, :school_initials, :course_id, :course_category_id, :description, :cpf, :name, :email, :user_id)
  end
  def contact_us_message_params
    params.permit(:user_id, :cpf, :name, :email, :description, :is_student)
  end
end
