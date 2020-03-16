Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:edit, :update]
  resources :items
  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :brands, only: [:index, :new, :create, :edit, :destroy]
  resources :orders
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
