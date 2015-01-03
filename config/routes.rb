Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root to: 'home#index'

  ActiveAdmin.routes(self)

  # Init active admin
  devise_for :admin_users, ActiveAdmin::Devise.config

  # Init login gem
  devise_for :users, controllers: {:sessions => 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations'}

  get 'delivery', to: 'delivery#index'
  get 'faq', to: 'faq#index'
  get '/products/search/(:token)(/category/:category)', to: 'products#search', :as => 'search'
  get '/products/filter/:category' => 'products#filter', :as => 'filter'
  get '/products/change_page/:page_number' => 'products#change_page'
  get '/home/change_page/:page_number' => 'home#change_page'
  get '/products/add_to_shopping_cart/:id&:quantity' => 'products#add_to_shopping_cart'
  get '/shopping_carts/pay' => 'shopping_carts#pay'
  get '/shopping_carts/success' => 'shopping_carts#success'
  get '/shopping_carts/cancel' => 'shopping_carts#cancel'

  resources :product_reviews
  resources :product_discounts
  resources :categories
  resources :product_images
  resources :manufacturers
  resources :about_us, only: :index
  resources :special_offers, only: :index
  resources :only_organics, only: :index
  resources :contacts, only: :index
  resources :shopping_carts, only: :index
  resources :products

end