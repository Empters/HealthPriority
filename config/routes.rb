Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root to: "home#index"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get '/products/search', to: 'products#search'

  resources :product_reviews
  resources :product_discounts
  resources :categories
  resources :product_images
  resources :manufacturers
  resources :about_us, only: :index
  resources :special_offers, only: :index
  resources :only_organics, only: :index
  resources :contacts, only: :index
  resources :shopping_cards, onlu: :index
  resources :products

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords", confirmations: "users/confirmations" }
end