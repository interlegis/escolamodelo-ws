Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
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
  post '/log_inn', to: 'sessions#create', as: :log_inn
  delete '/log_out', to: 'sessions#destroy', as: :log_out
  get '/log_out', to: 'sessions#destroy', as: :log_out_extern
  #Login com oauth
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback' # for use with Github, Facebook
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
  #Análises
  get '/analise' => 'reviews#index'
  post '/analise' => 'reviews#criar'
  patch '/analise' => 'reviews#atualizar'
  post '/analiseDeletar' => 'reviews#deletar'

  #Registro em curso
  get 'cursos/registro/' => 'course_registrations#new', :as => 'registro_curso'
  post 'cursos/registro/' => 'course_registrations#create', :as => 'registrado_curso'
  post '/cursos/confirmar' => 'course_registrations#confirmacao_matricula', :as => 'confirmacao'

  #Avaliação curso
  post '/curso/avaliar' => 'course_ratings#avaliar_curso', :as => 'avaliar_curso'
  get '/curso/avaliacoes' => 'course_ratings#index', :as => 'index'

  #Api Keys
  resources :api_accesses, only: [:new,:create,:index,:destroy]

  scope '/api' do
    scope '/v1' do
      #Cursos
      post '/cursos/registrar' => 'courses#registrar_curso', :as => 'registrar_curso'
      get '/cursos/aprovar' => 'courses#index_cursos_pendentes', :as => 'index_cursos_pendentes'
      post '/cursos/aprovar' => 'courses#aprovar_curso', :as => 'aprovar_curso'
      get '/cursos/' => 'courses#index', :as => 'cursos'
      post '/cursos/buscar' => 'courses#buscar_cursos', :as => 'buscar_cursos'
      #Categoria de curso
      post '/categorias_cursos/adicionar' => 'course_categories#adicionar_categoria', :as => 'adicionar_categoria'
      patch '/categorias_cursos/atualizar' => 'course_categories#atualizar_categoria', :as => 'atualizar_categoria'
      get '/categorias_cursos/' => 'course_categories#index', :as => 'categorias_cursos'
      #Escolas
      post '/escolas/registrar' => 'schools#registrar_escola', :as => 'registrar_escola'
      get '/escolas/' => 'schools#index', :as => 'escolas'
      #Registros de Cursos
      get '/registros/' => 'course_registrations#cursos_usuario', :as => 'cursos_usuario'
      #Certificados
      post 'certificados/adicionar' => 'certificates#adicionar_certificado', :as => 'adicionar_certificado'
      get 'certificados/detalhar' => 'certificates#detalhes_certificado', :as => 'detalhes_certificado'
      get 'certificados/' => 'certificates#certificado_usuario', :as => 'certificado_usuario'
      #Fale conosco
      post '/fale_conosco/conversa' => 'contact_us_conversations#index', :as => 'conversa'
      post '/fale_conosco/conversa_usuario' => 'contact_us_conversations#conversa_usuario', :as => 'conversa_usuario'
      post '/fale_conosco/mensagens' => 'contact_us_conversations#detalhar_conversa', :as => 'detalhar_conversa'
      post '/fale_conosco/adicionar' => 'contact_us_conversations#adicionar_conversa', :as => 'adicionar_conversa'
      post '/fale_conosco/apagar_mensagem' => 'contact_us_messages#apagar_mensagem', :as => 'apagar_mensagem'
      post '/fale_conosco/apagar_conversa' => 'contact_us_conversations#apagar_conversa', :as => 'apagar_conversa'
      patch '/fale_conosco/atualizar_mensagem' => 'contact_us_messages#atualizar_mensagem', :as => 'atualizar_mensagem'
    end
  end
end
