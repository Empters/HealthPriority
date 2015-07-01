Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root to: 'home#index'

  post 'import_products_post' => 'admin#import_products#import'

  ActiveAdmin.routes(self)

  # Init active admin
  devise_for :admin_users, ActiveAdmin::Devise.config

  # Init login gem
  devise_for :users, controllers: {:sessions => 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations'}

  get '/home/about_us', to: 'home#about_us', :as => 'about_us'
  get '/home/contacts', to: 'home#contacts', :as => 'contacts'
  get '/home/faq', to: 'home#faq', :as => 'faq'
  get '/home/our_partners', to: 'home#our_partners', :as => 'our_partners'
  get '/home/delivery_methods', to: 'home#delivery_methods', :as => 'delivery_methods'
  get '/home/rights_and_obligations', to: 'home#rights_and_obligations', :as => 'rights_and_obligations'
  get '/home/license', to: 'home#license', :as => 'license'
  get '/home/payment_methods', to: 'home#payment_methods', :as => 'payment_methods'
  get '/home/help_center', to: 'home#help_center', :as => 'help_center'
  get '/home/price_details', to: 'home#price_details', :as => 'price_details'
  get '/home/update_states', to: 'home#update_states', :as => 'update_states'
  post '/home/send_message', to: 'home#send_message'

  get '/products/search/:token&:category', to: 'products#search', :as => 'search'
  get '/products/autocomplete/:query', to: 'products#autocomplete'
  get '/products/filter', to: 'products#filter', :as => 'filter'

  get '/shopping_carts/index', to: 'shopping_carts#index'
  post '/shopping_carts/add_to_shopping_cart', to: 'shopping_carts#add_to_shopping_cart'
  post '/shopping_carts/set_product_count', to: 'shopping_carts#set_product_count'
  delete '/shopping_carts/remove_product', to: 'shopping_carts#remove_product'

  get '/orders/index', to: 'orders#index'
  get '/orders/show/:id', to: 'orders#show'
  post '/show/orders/:id', to: 'orders#show'
  post '/orders/hook', to: 'orders#hook'

  post '/products/:product/rate/', to: 'products#rate'

  resources :orders
  resources :products
  resources :product_images
  resources :product_reviews
  resources :product_discounts
  resources :manufacturers
  resources :categories, only: :index
  resources :shopping_carts, only: :index
  resources :special_offers, only: :index
  resources :only_organics, only: :index
  resources :users
  resources :sitemaps, only: :index
end