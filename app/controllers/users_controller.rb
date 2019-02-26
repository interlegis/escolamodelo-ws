class UsersController < ApplicationController
  def new
    if current_user
      redirect_to user_path
    end
    @user = User.new
  end

  def create #isso precisa ser alterado, se já existir cadastro deve entrar pela rede social e depois pode adicionar senha
    @user = User.new(user_params)
    @user.role_id = 2
    existent_user = User.find_by('email = ? or cpf = ?', user_params[:email], user_params[:cpf])
    conseguiu = false
    email_cpf_repetido = false




    if existent_user.present?









      if existent_user.crypted_password.present?
        email_cpf_repetido = true
      else
        redirect_to log_in_path(social: true)
      end
    elsif verify_recaptcha
      conseguiu = @user.save
    end
    if conseguiu
      o = [('a'..'z'), ('A'..'Z'), ('1' .. '9')].map(&:to_a).flatten
      key='a'
      loop do
        key=(0...50).map { o[rand(o.length)] }.join
        api=ApiAccess.find_by(key: key)
        break if !api.present?
      end
      @api=ApiAccess.new(user_id: @user.id, api_access_level_id: 1, key: key)
      login(params[:user][:email], params[:user][:password])
      redirect_to user_path(@user)
    else
      @user = User.new(user_params)
      if @user.password.length < 8
        flash.now[:senha] = 'A senha deve conter no mínimo 8 caracteres.'
      end
      if @user.password != @user.password_confirmation
        flash.now[:senha] = 'As senhas digitadas não coincidem.'
      end
      if email_cpf_repetido
        flash.now[:email] = 'Já existe usuário com esse e-mail ou CPF.'
      end
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
    if !params[:user][:password].present? #verifica se o login foi fornecida uma senha nova
      @user.skip_password = true
    end
    if @user.update(user_params)
      if @user.cpf.present? and @user.api_access.api_access_level_id == 1
        @user.api_access.update(api_access_level_id: 2)
      end
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
