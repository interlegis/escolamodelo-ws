class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      @user = create_from(provider)
      auto_login(@user)
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    end
  end
end
