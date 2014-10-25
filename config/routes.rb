Rails.application.routes.draw do

  root to: "home#index"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :product_reviews
  resources :product_discounts
  resources :categories
  resources :product_images
  resources :manufacturers
  resources :products

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords", confirmations: "users/confirmations" }

end