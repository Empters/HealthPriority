Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root to: "home#index"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get 'delivery', to: 'delivery#index'
  get 'faq', to: 'faq#index'
  get '/products/search/:token', to: 'products#search', :as => 'search'
  get '/products/filter/:category' => 'products#filter', :as => 'filter'

  resources :product_reviews
  resources :product_discounts
  resources :categories
  resources :product_images
  resources :manufacturers
  resources :about_us, only: :index
  resources :special_offers, only: :index
  resources :only_organics, only: :index
  resources :contacts, only: :index
  resources :shopping_cards, only: :index
  resources :products

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords", confirmations: "users/confirmations" }
end