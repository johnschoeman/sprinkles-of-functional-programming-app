Rails.application.routes.draw do
  root "products#index"

  resources :products, only: %i[index new create destroy edit update]
  resources :imports, only: %i[create]
end
