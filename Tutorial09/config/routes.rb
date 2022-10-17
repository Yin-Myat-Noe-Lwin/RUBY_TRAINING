Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  root "images#index"

  get "/new", to: "images#new"

  post "/success", to: "images#success"

  get "/fail" ,  to: "images#fail"
  
  # Defines the root path route ("/")
  # root "articles#index"
end
