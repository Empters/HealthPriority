Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root to: 'home#index'

  post 'import_products_post' => 'admin#import_products#import'

  ActiveAdmin.routes(self)

  # Init active admin
  devise_for :admin_users, ActiveAdmin::Devise.config

  # Init login gem
  devise_for :users, controllers: {:sessions => 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations'}

  get 'delivery', to: 'delivery#index'
  get 'faq', to: 'faq#index'
  get '/products/search/(:token)(/category/:category)', to: 'products#search', :as => 'search'
  get '/products/filter/:category' => 'products#filter', :as => 'filter'
  get '/products/brand/:brand' => 'products#brand', :as => 'brand'
  get '/products/price/:range' => 'products#price', :as => 'price'
  get '/products/change_page/:page_number' => 'products#change_page'
  get '/home/change_page/:page_number' => 'home#change_page'
  get '/products/add_to_shopping_cart/:id&:quantity' => 'products#add_to_shopping_cart'
  post "/products/set_product_count" => "products#set_product_count"
  get '/shopping_carts/pay', to: 'shopping_carts#pay'
  get '/shopping_carts/success', to: 'shopping_carts#success'
  get '/shopping_carts/cancel', to: 'shopping_carts#cancel'
  get '/shopping_carts/payments', to: 'shopping_carts#payments', :as => 'payments_list'
  post '/shopping_carts/payments', to: 'shopping_carts#pay', :as => 'pay'
  post "/payments/hook" => "payments#hook", :as => 'hook'
  post "/payments/:id" => "payments#show"

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
  resources :payments

end