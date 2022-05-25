Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'
  resources :carriers, only: [:index, :show, :edit, :update, :new, :create]
  resources :vehicles, only: [:index, :show, :new, :create, :edit, :update]
  resources :shipping_prices, only: [:index, :new, :create, :edit, :update]
end
