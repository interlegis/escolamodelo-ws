class ApiAccessesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def new
    if current_user
      if current_user.role_id == 1
        @api = ApiAccess.new
        @api_access_levels = ApiAccessLevel.all
        @users = User.all
      else
        redirect_to user_path
      end
    else
      redirect_to log_in_path
    end
  end

  def create
    if current_user
      if current_user.role_id == 1
        o = [('a'..'z'), ('A'..'Z'), ('1'..'9')].map(&:to_a).flatten
        key = 'a'
        loop do
          key = (0...50).map {o[rand(o.length)]}.join
          api = ApiAccess.find_by(key: key)
          break if !api.present?
        end
        @api = ApiAccess.new(user_id: params[:api_access][:user_id], api_access_level_id: params[:api_access][:api_access_level_id], key: key)
        if @api.save
          redirect_to api_accesses_path
        else
          flash.now[:erro] = 'Usuário já possui chave'
          render 'new'
        end
      else
        redirect_to user_path
      end
    else
      redirect_to log_in_path
    end
  end

  def index
    if !(current_user and current_user.role_id == 1)
      redirect_to user_path
    else
      @api_keys = ApiAccess.all
    end
  end

  def destroy
    if current_user
      if current_user.role_id == 1
        @api = ApiAccess.find(params[:id])
        @api.destroy
        redirect_to api_accesses_path
      else
        redirect_to user_path
      end
    else
      log_in_path
    end
  end
end