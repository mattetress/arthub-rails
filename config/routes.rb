Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static#home'
  get '/signup' => 'users#new', as: 'new_user'
  post '/signup' => 'users#create', as: 'users'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#facebook'
  resources :users, except: [:new, :create]
  get '/users/:id/update_photo' => 'users#change_avatar', as: 'edit_avatar'
  post '/users/:id/update_photo' => 'users#update_avatar'

end
