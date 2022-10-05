Rails.application.routes.draw do
 
  root "access#home"

  get "home"    => "access#home"

  get "login"   => "access#new"

  get "logout"  => "access#destroy"

  resource :access, controller: 'access'

end