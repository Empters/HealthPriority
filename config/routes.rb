Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "home#index"

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords", confirmations: "users/confirmations" }

  resources :products
  resources :about_us, only: :index
  resources :special_offers, only: :index
  resources :only_organics, only: :index
  resources :contacts, only: :index
  resources :shopping_cards, onlu: :index
end