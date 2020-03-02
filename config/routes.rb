Rails.application.routes.draw do
  root 'users#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  resources :users, only: [:create, :show] do
    member do
      get :following, :followers
    end
  end
  resources :messages, only: :create
  resources :relationships, only: [:create, :destroy]
end
