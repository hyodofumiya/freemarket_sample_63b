Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    resources :favorites, only: [:index]
    resources :credit_cards, only: [:index]
    resources :shopping_addresses, only: [:index]
    resources :items, only: [:index, :new, :create, :show]
    resources :orders, only: [:index, :new, :create]

  end
  resources :items, only: [:index, :show]
 
  root 'items#index'
 
end
