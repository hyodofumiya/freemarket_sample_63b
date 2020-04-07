Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  devise_scope :user do
    get 'shopping_addresses', to: 'users/registrations#new_address'
    post 'shopping_addresses', to: 'users/registrations#create_address'
  end

  resources :users, only: [:show, :edit, :update] do
    resources :favorites, only: [:index]
    resources :credit_cards, only: [:index, :show, :new, :create, :destroy, :purchase]
    resources :shopping_addresses, only: [:index]
    resources :items, only: [:index, :new, :create, :show]
    resources :orders, only: [:index, :new, :create]
    resources :orders do
      member do
        post 'purchase'
      end
    end
  end
  resources :items, only: [:index, :show]
  
  root 'items#index'
 
end
