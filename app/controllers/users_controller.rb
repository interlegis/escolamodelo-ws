class UsersController < ApplicationController
  def new
    if current_user
      redirect_to user_path
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role_id = 2

    if @user.save
      flash[:success] = 'Bem vindo!'
      login(params[:user][:email], params[:user][:password])
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    if current_user
      if !current_user.cpf.present?
        redirect_to adicionar_dados_path
      elsif current_user and current_user.role.id == 1
        redirect_to painel_path
      else
        @user = current_user
      end
    else
      redirect_to log_in_path
    end
  end

  def edit
    if !current_user.cpf.present?
      redirect_to adicionar_dados_path
    end
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to log_in_path
    end
    if @user.external?
      @user.skip_password = true
    end
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_path
    end
    logout
    @user.destroy
    redirect_to root_path
  end

  def painel
    unless current_user and current_user.role.id == 1
      redirect_to log_in_path
    end
  end

  def adicionar_dados
    if current_user
      if current_user.cpf.present?
        redirect_to user_path
      else
        @user = current_user
      end
    else
      redirect_to log_in_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :first_name, :last_name, :cpf,
                                 :birth, :phone, :username
                                 )
  end
end
