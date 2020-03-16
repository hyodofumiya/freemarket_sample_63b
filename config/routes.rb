Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    resources :items, only: [:index, :show, :new, :create]
    resources :favorites, only: [:index]
    resources :credit_cards, only: [:index]
    resources :shopping_addresses, only: [:index]
    resources :orders, only: [:index, :new, :create]
  end
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
  get 'items/edit'
  get 'items/update'
  get 'items/destroy'
  get 'orders/edit'
  get 'orders/update'
  get 'orders/destroy'
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
