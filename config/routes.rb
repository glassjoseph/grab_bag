Rails.application.routes.draw do
  get 'folders/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index', as: :landing_page

  get '/auth/facebook', as: :facebook_login
  get '/auth/facebook/callback', to: "sessions#create", as: :facebook_callback
  get '/sign_up', to: 'sign_up#new'
  post '/sign_up', to: 'sign_up#create'
  get '/:username/*route', to: 'folders#show', as: :folder

end
