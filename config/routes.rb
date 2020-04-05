Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  devise_scope :user do
    get 'shopping_addresses', to: 'users/registrations#new_address'
    post 'shopping_addresses', to: 'users/registrations#create_address'
  end

  resources :users, only: [:show, :edit, :update] do
    resources :favorites, only: [:index]
    resources :credit_cards, only: [:index]
    resources :shopping_addresses, only: [:index]
    resources :items, only: [:index, :new, :create, :show]
    resources :orders, only: [:index]
    get "profile_photo", to: "users#profile_photo"
    patch "update_profile_photo", to: "users#profile_photo_update"
  end
  resources :items, only: [:index, :edit, :show, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :comments, only: [:create]
    resources :orders, only: [:new, :create]#orderはuserにも関係するがcurrent_userでとるのでitemにネストする。
  end
  resources :items, only: [:index, :show]

  root 'items#index'

end
