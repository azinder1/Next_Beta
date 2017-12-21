Rails.application.routes.draw do
  namespace :admin do
    resources :comments
    resources :routes
    resources :users

    root to: "comments#index"
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root to: 'landing#index'
  resources :routes do
    resources :comments
  end
  resources :users
end
