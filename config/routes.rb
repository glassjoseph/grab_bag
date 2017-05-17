Rails.application.routes.draw do
  resources :folders, only: [:index]
end
