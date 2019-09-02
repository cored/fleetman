Rails.application.routes.draw do
  root to: "search#new"
  resources :vehicles, only: [:index]
  resource :search, only: [:create, :new], controller: "search"
end
