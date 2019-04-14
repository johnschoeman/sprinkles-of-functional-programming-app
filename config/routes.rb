Rails.application.routes.draw do
  root "products#index"

  resources :products
  resources :imports, only: %i[create]
end
