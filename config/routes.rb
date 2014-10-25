Rails.application.routes.draw do
  mount Rich::Engine => '/rich', :as => 'rich'
  root to: "home#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :product_reviews
  resources :product_discounts
  resources :categories
  resources :product_images
  resources :manufacturers
  resources :products

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
end