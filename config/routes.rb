Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:edit, :update]
  resources :credit_cards, only: [:new, :create, :index, :show]
  resources :shoppling_addresses, only:[:new, :create, :index]
  resources :orders, only: [:index, :new, :create, :edit, :update, :destroy]
  get 'categories/index'
  get 'categories/new'
  get 'categories/create'
  get 'categories/edit'
  get 'categories/update'
  get 'categories/destroy'
  get 'brands/index'
  get 'brands/new'
  get 'brands/create'
  get 'brands/edit'
  get 'brands/update'
  get 'brands/destroy'
  get 'items/index'
  get 'items/new'
  get 'items/create'
  get 'items/edit'
  get 'items/update'
  get 'items/destroy'

  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
