require "sidekiq/web"

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  # 🏠 Home
  root "products#index"

  # 🛍 Products
  resources :products, only: [ :index, :show ]

  # 🛒 Cart
  resource :cart, only: [ :show ] do
    resources :cart_items, only: [ :create, :destroy ]
  end

  # 📦 Orders
  resources :orders, only: [ :create, :show ]

  # 💳 Razorpay checkout
  post "/checkout", to: "orders#create"
  post "/verify_payment", to: "orders#verify_payment"

  # 📊 Sidekiq
  mount Sidekiq::Web => "/sidekiq"

  # 📧 Emails preview
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
