Rails.application.routes.draw do

  root to: "users#dashboard"
 
  get '/home' => 'users#home'

  post '/home' => 'users#signup'

  get '/dashboard' => 'users#dashboard'

  get '/board' => 'sessions#board'

  post '/board' => "sessions#create"

  delete '/logout' => "sessions#destroy"

  get '/reset' => 'users#reset'

  post '/reset' => "users#resetPassword"

  resources :users

end