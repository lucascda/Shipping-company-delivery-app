Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'
  resources :carriers, only: [:index, :show, :edit, :update, :new, :create]
  resources :vehicles, only: [:index, :show, :new, :create, :edit, :update]
  resources :shipping_prices, only: [:index, :new, :create, :edit, :update] do
    get 'search', on: :collection
  end
  resources :delivery_times, only: [:index, :new, :create, :edit, :update]
  resources :order_services, only: [:index, :show, :new, :create, :update] do
    resources :order_routes, only: [:index, :new, :create]
    get 'users_index', on: :collection
    get 'users_show', on: :member
    get 'accepted-orders', on: :collection    
    patch 'new-accepted', on: :member    
    post 'refused', on: :member
  end
  
end
