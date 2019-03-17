Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static#home'

  get '/signup' => 'users#new', as: 'new_user'

  post '/signup' => 'users#create', as: 'users'

  get '/login' => 'sessions#new'

  post '/login' => 'sessions#create'

  delete '/logout' => 'sessions#destroy'

  get '/auth/facebook/callback' => 'sessions#facebook'

  resources :users, except: [:new, :create] do
    resources :artworks
  end

  get '/users/:id/update_photo' => 'users#change_avatar', as: 'edit_avatar'

  post '/users/:id/update_photo' => 'users#update_avatar'

  get '/users/:id/upload_resume' => 'users#new_resume', as: 'new_user_resume'

  post '/users/:id/upload_resume' => 'users#attach_resume'

  patch '/users/:id/upload_resume' => 'users#attach_resume'

  get '/events/past' => 'events#past_events', as: 'past_events'

  get '/events/:id/interested' => 'events#add_interest', as: 'add_interest'

  get '/events/:id/remove_interest' => 'events#remove_interest', as: 'remove_interest'

  resources :events



end
