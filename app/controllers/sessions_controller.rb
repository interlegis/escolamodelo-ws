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
        render js: "window.location='#{'https://evl.interlegis.leg.br'}'"
      else
        school=School.find_by_initials(params[:user][:return])
        if school.present?
          render js: "window.location='#{school.url}'"
        else
          render js: "window.location='#{user_path}'"
        end
      end

    else
      render new
      render status: 400, json: {error: 'Email ou senha incorretos'}.to_json
    end
  end

  def destroy
    logout
    redirect_to log_in_path
  end
end
