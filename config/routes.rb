Rails.application.routes.draw do
  use_doorkeeper_openid_connect
  get 'pages/index'
  use_doorkeeper
  root 'pages#index'
  get '/minha_conta' => 'users#show', :as => 'user'
  resources :users, only: [:new, :create, :edit, :update, :destroy]
  get '/painel' => 'users#painel', :as => 'painel'
  get '/sign_up' => 'users#new', :as => 'sign_up'
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out
  scope '/api' do
    scope '/v1' do
      #Cursos
      post '/courses/adicionar' => 'courses#adicionar_curso', :as => 'adicionar_curso'
      patch '/courses/atualizar' => 'courses#atualizar_curso', :as => 'atualizar_curso'
      get '/courses/' => 'courses#index', :as => 'cursos'
    end
  end
end
