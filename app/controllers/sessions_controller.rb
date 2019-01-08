class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :destroy
  def new
    if current_user
      redirect_to root_path
    else
      @social = params[:social] #indica que o login deve ser feito por redes sociais
      @retorno = params[:return]
    end
  end

  def create
    if login(params[:user][:email], params[:user][:password])
      redirect_to params[:user][:return]
    else
      @retorno = params[:user][:return]
      render 'new'
    end
  end

  def destroy

    if params[:externo].present?
      logout
      redirect_to params[:externo]
    else
      logout
      redirect_to log_in_path
    end

  end
end
