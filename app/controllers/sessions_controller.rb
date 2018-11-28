class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to root_path
    else
      @retorno = params[:return]
    end
  end

  def create
    if login(params[:user][:email], params[:user][:password])
      if params[:user][:return] == 'evl'
        redirect_to 'https://evl.interlegis.leg.br'
      else
        school=School.find_by_initials(params[:user][:return])
        if school.present?
          redirect_to school.url
        else
          redirect_to user_path
        end
      end

    else
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to log_in_path
  end
end
