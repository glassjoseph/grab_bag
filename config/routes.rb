Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'landing#index', as: :landing_page

  get '/auth/facebook', as: :facebook_login
  get '/auth/facebook/callback', to: "sessions#create", as: :facebook_callback
  get '/sign_up', to: 'sign_up#new'
  post '/sign_up', to: 'sign_up#create'
  get '/:username/dashboard', to: 'users#show', as: :dashboard
  get '/:username/dashboard/edit', to: 'users#edit', as: :dashboard_edit
  patch '/:username/dashboard/edit', to: 'users#update', as: :dashboard_patch

  get '/:username/dashboard/change_password', to: 'passwords#edit', as: :password_edit

  namespace :users, path: ":username" do
    resources :folders, only: [:index, :new, :create]
  end

  get '/:username/*route', to: 'users/folders#show', as: :folder

  #send url of nested folders to folders#new?

end
