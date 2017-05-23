Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'landing#index', as: :landing_page

  get '/auth/facebook', as: :facebook_login
  get '/auth/facebook/callback', to: "sessions#create", as: :facebook_callback

  get '/sign_up', to: 'sign_up#new'
  post '/sign_up', to: 'sign_up#create'

  namespace :users, path: ":username" do
    get '/dashboard', to: 'users#show', as: :dashboard
    get '/dashboard/edit', to: 'users#edit', as: :dashboard_edit
    patch '/dashboard/edit', to: 'users#update', as: :dashboard_patch

    get '/dashboard/change_password', to: 'passwords#edit', as: :password_edit

    get '/*route/folder_new', to: 'folders#new', as: :new_folder
    get '/*route/:binary_name', to: 'folders/binaries#show', as: :binary, format: true
    get '/*route/binary_new', to: 'folders/binaries#new', as: :new_binary

    post '/*route', to: 'folders/binaries#create', as: :binaries, constraints: { parameters: /binary/ }
    post '/*route', to: 'folders#create', as: :folders, constraints: { parameters: /folder/ }

    get '/*route', to: 'folders#show', as: :folder
  end

  resources :folders, only: :index
end
