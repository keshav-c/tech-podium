Rails.application.routes.draw do
  root 'users#show'
  get '/login', to: 'sessions#new'
end
