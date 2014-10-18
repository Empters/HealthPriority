Rails.application.routes.draw do
  resources :product_reviews

  resources :product_discounts

  resources :categories

  resources :product_images

  resources :manufacturers

  root :to => "home#index"

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
  end

  resources :products

  get ':controller(/:action(/:id(.:format)))'
end