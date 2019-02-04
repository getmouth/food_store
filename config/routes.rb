Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :cities
  resources :products
  resources :carts

  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
