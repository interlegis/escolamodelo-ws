Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
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
  #Login com oauth
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback' # for use with Github, Facebook
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
  scope '/api' do
    scope '/v1' do
      #Cursos
      post '/courses/adicionar' => 'courses#adicionar_curso', :as => 'adicionar_curso'
      patch '/courses/atualizar' => 'courses#atualizar_curso', :as => 'atualizar_curso'
      get '/courses/' => 'courses#index', :as => 'cursos'
      #Categoria de curso
      post '/courses_categories/adicionar' => 'course_categories#adicionar_curso', :as => 'adicionar_categoria'
      patch '/courses_categories/atualizar' => 'course_categories#atualizar_curso', :as => 'atualizar_categoria'
      get '/courses_categories/' => 'course_categories#index', :as => 'categorias_cursos'
    end
  end
end
