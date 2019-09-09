class ContactUsConversationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :basic_api_access, only: [:index]
  before_action :user_data_access, only: [:conversa_usuario, :adicionar_conversa, :detalhar_conversa, :atualizar_conversa]

  def index
    if params[:was_answered] == true
      conversations = ContactUsConversation.where(school_id: @school.id, was_answered: true).order("updated_at")
    else
      conversations = ContactUsConversation.where(school_id: @school.id, was_answered: false).order("created_at")
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
      render json: hash_conversation, status: 200, quantidade_mensagem: conversations.size
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
      render json: hash_conversation, status: 200, quantidade_mensagem: conversations.size
    end
  end

  def conversa_usuario
    user = User.find_by(cpf: @api[:cpf])
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
      render json: hash_conversation_user
    end
  rescue StandardError => e
    render status: 400, json: {
        message: "Não existe usuário com este cpf."
    }.to_json
  end

  def adicionar_conversa # TODO apenas com a chave do usuário ou o admin também pode adicionar?
    if params[:conversation_id].present? # Se a conversa já existir
      user = User.find_by(cpf: @api[:cpf])
      @conversation = ContactUsConversation.find_by(id: params[:conversation_id], user: user)
      if params[:is_student] != false
        puts params[:is_student]
        @conversation.update(:was_answered => false)
      else
        @conversation.update(:was_answered => true)
      end
    else # Conversa ainda não existe
      user = User.find_by(cpf: @api[:cpf])
      if user.nil?
        return render status: 404, json: {
            message: "Ocorreu um erro! CPF não encontrado no sistema."
        }.to_json
      end
      if params[:school_initials].present? == true and user.present? # TODO enteender como isso pode ser utilizado com o usuário
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
    user = User.find_by(cpf: @api[:cpf])
    if user.present?
      @conversation = user.role.id == 1 ? ContactUsConversation.find_by(id: params[:conversation_id]) : ContactUsConversation.find_by(id: params[:conversation_id], user: user)
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
          render json: hash_messages_school
        end
      else
        render status: 400, json: {
            message: "Conversa não encontrada."
        }.to_json
      end
    else
      render status: 400, json: {
          message: "Conversa não encontrada."
      }.to_json
    end
  end

  # Método não utilizado atualmente
  def atualizar_conversa
    user = User.find_by(cpf: @api[:cpf])
    if user.present?
      @conversation = user.role.id == 1 ? ContactUsConversation.find_by(id: params[:conversation_id]) : ContactUsConversation.find_by(id: params[:conversation_id], user: user)
      if @conversation.update(contact_us_conversation_params)
        render status: 200, json: {
            message: "Conversa atualizada com sucesso",
        }.to_json
      else
        render status: 400, json: {
            message: "Ocorreu um erro"
        }.to_json
      end
    else
      render status: 400, json: {
          message: "Ocorreu um erro"
      }.to_json
    end
  end

  def apagar_conversa
    user = User.find_by(cpf: @api[:cpf])
    if user.present?
      @conversation = user.role.id == 1 ? ContactUsConversation.find_by(id: params[:conversation_id]) : ContactUsConversation.find_by(id: params[:conversation_id], user: user)
      if @conversation.present?
        @conversation.destroy
        render json: @conversation
      else
        render status: 400, json: {
            message: "Conversa não encontrada"
        }.to_json
      end
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
    params.permit(:user_id, :cpf, :name, :email, :phone, :description, :is_student)
  end
end
