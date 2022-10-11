Rails.application.routes.draw do

  root "files#read"

  get "/read", to: "files#read"

  post "/show", to: "files#show"

end