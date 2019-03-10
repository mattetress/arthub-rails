Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static#home'
  get '/signup' => 'users#new', as: 'new_user'
  post '/signup' => 'users#create', as: 'users'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  resources :users, except: [:new, :create]

end
