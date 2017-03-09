Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root to: 'landing#index'
  resources :routes do
    resources :comments
  end
  resources :users
end
