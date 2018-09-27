class ContactUsMessagesController < ApplicationController
  require 'date'
  skip_before_action :verify_authenticity_token

  def index
    messages = ContactUsMessage.all
    render json:messages
  end

  def mensagem_escola
    #Filtra as mensagens de acordo com a escola e ordena por data
    hash_messages_schools = ContactUsMessage.where(school_initials: params[:school_initial], was_answered: false).order("created_at")
    #Caso a quantidade de mensagens por página seja menor que um
    if params[:limit].to_i <= 0
      return render status: 400, json: {
        message: "Não é possível criar uma página com este tamanho",
      }.to_json
    #Caso a página não exista
    #hash_messages_schools.size.to_f -> Total de mensagens
    #params[:limit] -> total de mensagens por página
    elsif params[:page].to_i > (hash_messages_schools.size.to_f/params[:limit].to_f).ceil
      return render status: 400, json: {
        message: "Esta página não existe",
      }.to_json
    else
      hash_messages_schools = hash_messages_schools.page(params[:page]).per(params[:limit]).map do |c|
        {
          'id' => c.id,
          'description' => c.description,
          'cpf' => c.cpf,
          'email' => c.email,
          'respondida' => c.was_answered,
        }
      end
      return render json:hash_messages_schools
    end
  end

  # Cliente
  def adicionar_mensagem
    if params[:id_conversation].present?
      @conversation = ContactUsConversation.find(params[:id_conversation])
      @message = @conversation.contact_us_message.create(contact_us_message_params.merge({:is_student=>true}))
    else
      @conversation = ContactUsConversation.create(title: params[:name], description: params[:description], initial_date:  DateTime.now.to_date)
      @message = @conversation.contact_us_message.create(contact_us_message_params.merge({:is_student=>true}))
    end
    if @message.save
      render status: 200, json: {
        message: "Mensagem enviada com sucesso",
      }.to_json
    else
      render status: 400, json: {
        message: "Ocorreu um erro"
      }.to_json
    end
  end

  # Servidor
  def responder_mensagem
    @conversation = ContactUsConversation.where(id: params[:id_conversation]).first
    @answer = @conversation.contact_us_message.create(contact_us_answer_params.merge({:is_student=>false}))
    if @answer.save
      @conversation.contact_us_message.update_all(was_answered: true)
      render status: 200, json: {
        message: "A resposta foi enviada com sucesso",
      }.to_json
    else
      render status: 400, json: {
        message: "Ocorreu um erro"
      }.to_json
    end
  end

  def apagar_mensagem
    @message = ContactUsMessage.where(id: params[:message_id]).first
    if @message.present?
      @message.destroy
      render json:@message
    else
      render status: 400, json: {
        message: "Mensagem não encontrada"
      }.to_json
    end
  end

  private
  def contact_us_message_params
    params.permit(:name, :email, :cpf, :description, :school_initials, :course_category_id, :course_id)
  end
  def contact_us_answer_params
    params.permit(:name, :email, :cpf, :description)
  end

end
