class UsersController < ApplicationController
  def new
    if current_user
      redirect_to root_path
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
    @user = current_user
    if current_user.nil?
      redirect_to new_session_path
    elsif current_user and current_user.role.id == 1
      redirect_to painel_path
    end
  end

  def edit
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_path
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
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name,
                                 :cpf, :birth, :phone, :username,
                                 :password, :password_confirmation)
  end
end
