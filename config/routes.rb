Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root to: 'home#index'

  post 'import_products_post' => 'admin#import_products#import'

  ActiveAdmin.routes(self)

  # Init active admin
  devise_for :admin_users, ActiveAdmin::Devise.config

  # Init login gem
  devise_for :users, controllers: {:sessions => 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations'}

  get '/home/change_page/:page_number' => 'home#change_page'
  get '/home/about_us' => 'home#about_us'
  get '/home/contacts' => 'home#contacts'
  get '/home/faq' => 'home#faq'
  get '/home/our_partners' => 'home#our_partners'
  get '/home/delivery_methods' => 'home#delivery_methods'
  get '/home/payment_methods' => 'home#payment_methods'
  get '/home/help_center' => 'home#help_center'
  get '/home/price_details' => 'home#price_details'

  get '/products/search/(:token)(/category/:category)', to: 'products#search', :as => 'search'
  get '/products/filter/:category' => 'products#filter', :as => 'filter'
  get '/products/brand/:brand' => 'products#brand', :as => 'brand'
  get '/products/price/:range' => 'products#price', :as => 'price'
  get '/products/change_page/:page_number' => 'products#change_page'

  get '/shopping_carts/pay', to: 'shopping_carts#pay'
  get '/shopping_carts/success', to: 'shopping_carts#success'
  get '/shopping_carts/cancel', to: 'shopping_carts#cancel'
  get '/shopping_carts/payments', to: 'shopping_carts#payments', :as => 'payments_list'
  get '/shopping_carts/add_to_shopping_cart/:id&:quantity' => 'shopping_carts#add_to_shopping_cart'
  post '/shopping_carts/payments', to: 'shopping_carts#pay', :as => 'pay'
  post '/shopping_carts/set_product_count' => 'shopping_carts#set_product_count'
  delete '/shopping_carts/remove_product' => 'shopping_carts#remove_product'

  get '/payments/show/:id' => 'payments#show'
  post '/payments/hook' => 'payments#hook'

  resources :payments
  resources :products
  resources :product_images
  resources :product_reviews
  resources :product_discounts
  resources :categories
  resources :manufacturers
  resources :shopping_carts, only: :index
  resources :special_offers, only: :index
  resources :only_organics, only: :index

end