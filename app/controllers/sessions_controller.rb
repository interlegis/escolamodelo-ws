class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to root_path
    end
  end

  def create
    if login(params[:user][:email], params[:user][:password])
      render js: "window.location='#{user_path}'"
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
