class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    @retorno = session[:login_back_url]
    session[:login_back_url] = user_path
    if @user = login_from(provider)
      redirect_to @retorno, :notice => "Logged in from #{provider.titleize}!"
    else
      @user = build_from(provider)
      existent_user = User.find_by(email: @user.email)
      if !existent_user.present?
        @user = create_from(provider)
        o = [('a'..'z'), ('A'..'Z'), ('1' .. '9')].map(&:to_a).flatten
        key='a'
        loop do
          key=(0...50).map { o[rand(o.length)] }.join
          api=ApiAccess.find_by(key: key)
          break if !api.present?
        end
        @api=ApiAccess.create(user_id: @user.id, api_access_level_id: 1, key: key)
      else
        Authentication.create(provider: provider, user_id: existent_user.id, uid: @user.uid)
        @user = existent_user
      end
      auto_login(@user)
      session[:login_back_url] = @retorno
      redirect_to adicionar_dados_path, :notice => "Logged in from #{provider.titleize}!"
    end
  end
end
