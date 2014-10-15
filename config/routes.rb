Rails.application.routes.draw do
  root :to => "home#index"

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
  end

  resources :products
end