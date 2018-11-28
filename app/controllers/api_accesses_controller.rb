class ApiAccessesController < ApplicationController
  def new
    if !(current_user and current_user.role_id == 1)
      redirect_to user_path
    else
      @api = ApiAccess.new
    end
  end
  def create
    if current_user and current_user.role_id = 1
      user=User.find_by_cpf(params[:api][:user])
      if user.present?
        o = [('a'..'z'), ('A'..'Z'), ('1' .. '9')].map(&:to_a).flatten
        key='a'
        loop do
          key=(0...50).map { o[rand(o.length)] }.join
          api=ApiAccess.find_by(key: key)
          break if !api.present?
        end
        @api=ApiAccess.new(user_id: user.id, api_access_level_id: params[:api][:level], key: key)
        if @api.save
          redirect_to api_accesses_path
        else
          flash.now[:erro] = 'Usuário já possui chave'
          render 'new'
        end
      else
        flash.now[:erro] = 'Usuário inexistente'
        render 'new'
      end
    else
      redirect_to user_path
    end
  end
  def index
    if !(current_user and current_user.role_id = 1)
      redirect_to user_path
    else
      @api_keys = ApiAccess.all
    end
  end
  def destroy
    if current_user and current_user.role_id = 1
      @api = ApiAccess.find(params[:id])
      @api.destroy
      redirect_to api_accesses_path
    else
      redirect_to user_path
    end
  end
end
