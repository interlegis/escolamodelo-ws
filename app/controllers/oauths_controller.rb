class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to user_path, :notice => "Logged in from #{provider.titleize}!"
    else
      @user = build_from(provider)
      existent_user = User.find_by(email: @user.email)
      if !existent_user.present?
        @user = create_from(provider)
      else
        Authentication.create(provider: provider, user_id: existent_user.id, uid: @user.uid)
        @user = existent_user
      end
      auto_login(@user)
      redirect_to adicionar_dados_path, :notice => "Logged in from #{provider.titleize}!"
    end
  end
end
