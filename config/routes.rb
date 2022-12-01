Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :orders, only: [:index, :create, :update]
  resources :items, only: [:index, :create]
  resources :discount_combos, only: [:index, :create]
end
