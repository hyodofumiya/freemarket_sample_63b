Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  devise_scope :user do
    get 'shopping_addresses', to: 'users/registrations#new_address'
    post 'shopping_addresses', to: 'users/registrations#create_address'
  end

  resources :users, only: [:show, :edit, :update] do
    resources :favorites, only: [:index]
    resources :credit_cards, only: [:index, :show, :new, :create, :destroy]
    resources :shopping_addresses, only: [:index]
    resources :items, only: [:index, :new, :create, :edit, :update, :show]
    resources :orders, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get "profile_photo", to: "users#profile_photo"
    patch "update_profile_photo", to: "users#profile_photo_update"
  end
  resources :items, only: [:index, :show, :new, :create, :edit, :update, :show, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :comments, only: [:create]
    resources :orders, only: [:new, :create]#orderはuserにも関係するがcurrent_userでとるので購入に関わることはitemにネストする。
  end
  resources :categories, only: [:index, :show]

  root 'items#index'

end
