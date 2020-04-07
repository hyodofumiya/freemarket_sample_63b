Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    resources :favorites, only: [:index]
    resources :credit_cards, only: [:index]
    resources :shopping_addresses, only: [:index]
    resources :items, only: [:index, :new, :create, :show]
    resources :orders, only: [:index, :new, :create]

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "profile_photo", to: "users#profile_photo"
  patch "update_profile_photo", to: "users#profile_photo_update"
  resources :items, only: [:index, :new, :create, :show] do
    resources :categories, only: [:index, :show]
    resources :favorite, only: [:create, :destroy]
    resources :comments, only: [:create]
    resources :orders, only: [:new, :create]#orderはuserにも関係するがcurrent_userでとるのでitemにネストする。
  end
  root 'items#index'
end
