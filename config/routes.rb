Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
  use_doorkeeper_openid_connect
  get 'pages/index'
  use_doorkeeper
  root 'pages#index'
  get '/minha_conta' => 'users#show', :as => 'user'
  resources :users, only: [:new, :create, :edit, :destroy]
  patch '/users/:id' => 'users#update', :as => 'atualizar_usuario'
  get '/users/dados' => 'users#adicionar_dados', :as => 'adicionar_dados'
  get '/painel' => 'users#painel', :as => 'painel'
  get '/sign_up' => 'users#new', :as => 'sign_up'
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:new, :create]
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out
  #Login com oauth
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback' # for use with Github, Facebook
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
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
      get 'certificados/' => 'certificates#certificado_usuario', :as => 'certificado_usuario'
      #Fale conosco
      post '/fale_conosco/conversa' => 'contact_us_conversations#index', :as => 'conversa'
      post '/fale_conosco/mensagens' => 'contact_us_conversations#visualizar_mensagens', :as => 'mensagens'
      post '/fale_conosco/adicionar' => 'contact_us_conversations#adicionar_mensagem', :as => 'adicionar_mensagem'
      post '/fale_conosco/apagar_mensagem' => 'contact_us_messages#apagar_mensagem', :as => 'apagar_mensagem'
      post '/fale_conosco/apagar_conversa' => 'contact_us_conversations#apagar_conversa', :as => 'apagar_conversa'
      patch '/fale_conosco/atualizar_mensagem' => 'contact_us_messages#atualizar_mensagem', :as => 'atualizar_mensagem'
    end
  end
end
