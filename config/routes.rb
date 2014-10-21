Rails.application.routes.draw do
<<<<<<< HEAD

  devise_for :users
=======
>>>>>>> master
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: "home#index"

<<<<<<< HEAD
  root :to => "home#index"

  resources :product_reviews
  resources :product_discounts
  resources :categories
  resources :product_images
  resources :manufacturers
  resources :products
  resources :users

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
  end

  get ':controller(/:action(/:id(.:format)))'

=======
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
>>>>>>> master
end