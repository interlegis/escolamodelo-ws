Rails.application.routes.draw do
  use_doorkeeper_openid_connect
  get 'pages/index'
  root 'pages#index'
  namespace :api do
    get 'user', to: 'users#show'
  end
  devise_for :users
  use_doorkeeper
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
