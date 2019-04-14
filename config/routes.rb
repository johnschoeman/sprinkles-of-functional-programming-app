Rails.application.routes.draw do
  root "products#index"

  resources :products, only: %i[index new create destroy]
end
