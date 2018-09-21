class ContactUsMessagesController < ApplicationController
  require 'date'
  skip_before_action :verify_authenticity_token

  def index
    messages = ContactUsMessage.all
    render json:messages
  end

  def mensagem_escola
    #Filtra as mensagens de acordo com a escola e ordena por data
    hash_messages_schools = ContactUsMessage.where(school_initials: params[:school_initial]).order("created_at")
    #Caso a quantidade de mensagens por página seja menor que um
    if params[:limit].to_i <= 0
      return render status: 400, json: {
        message: "Não é possível criar uma página com este tamanho",
      }.to_json
    #Caso a página não exista
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
        }
      end
      return render json:hash_messages_schools
    end
  end

  def adicionar_mensagem
    @mensagem = ContactUsMessage.new(contact_us_params)
    puts @mensagem.name
    puts contact_us_params
    if @mensagem.save
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
    params.permit(:name, :email, :cpf, :description, :date, :school_initials, :course_category_id, :course_id)
  end
end
