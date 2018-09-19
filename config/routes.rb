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
      post '/cursos/adicionar' => 'courses#adicionar_curso', :as => 'adicionar_curso'
      patch '/cursos/atualizar' => 'courses#atualizar_curso', :as => 'atualizar_curso'
      get '/cursos/' => 'courses#index', :as => 'cursos'
      #Categoria de curso
      post '/categorias_cursos/adicionar' => 'course_categories#adicionar_categoria', :as => 'adicionar_categoria'
      patch '/categorias_cursos/atualizar' => 'course_categories#atualizar_categoria', :as => 'atualizar_categoria'
      get '/categorias_cursos/' => 'course_categories#index', :as => 'categorias_cursos'
      #Categoria de curso
      post '/escolas/adicionar' => 'schools#adicionar_escola', :as => 'adicionar_escola'
      patch '/escolas/atualizar' => 'schools#atualizar_escola', :as => 'atualizar_escola'
      get '/escolas/' => 'schools#index', :as => 'escolas'
      #Certificados
      post 'certificados/adicionar' => 'certificates#adicionar_certificado', :as => 'adicionar_certificado'
      get 'certificados/:cpf' => 'certificates#certificado_usuario', :as => 'certificado_usuario'
    end
  end
end
