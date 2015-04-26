Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root to: 'home#index'

  post 'import_products_post' => 'admin#import_products#import'

  ActiveAdmin.routes(self)

  # Init active admin
  devise_for :admin_users, ActiveAdmin::Devise.config

  # Init login gem
  devise_for :users, controllers: {:sessions => 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations'}

  get '/home/change_page/:page_number', to: 'home#change_page'
  get '/home/about_us', to: 'home#about_us', :as => 'about_us'
  get '/home/contacts', to: 'home#contacts', :as => 'contacts'
  get '/home/faq', to: 'home#faq', :as => 'faq'
  get '/home/our_partners', to: 'home#our_partners', :as => 'our_partners'
  get '/home/delivery_methods', to: 'home#delivery_methods', :as => 'delivery_methods'
  get '/home/payment_methods', to: 'home#payment_methods', :as => 'payment_methods'
  get '/home/help_center', to: 'home#help_center', :as => 'help_center'
  get '/home/price_details', to: 'home#price_details', :as => 'price_details'
  get '/home/update_states', to: 'home#update_states', :as => 'update_states'
  post '/home/send_message', to: 'home#send_message'

  get '/products/search/(:token)(/category/:category)', to: 'products#search', :as => 'search'
  get '/products/autocomplete/:query', to: 'products#autocomplete'
  get '/products/filter/:category', to: 'products#filter', :as => 'filter'
  get '/products/brand/:brand', to: 'products#brand', :as => 'brand'
  get '/products/price/:range', to: 'products#price', :as => 'price'
  get '/products/change_page/:page_number', to: 'products#change_page'

  get '/shopping_carts/pay', to: 'shopping_carts#pay'
  get '/shopping_carts/success', to: 'shopping_carts#success'
  get '/shopping_carts/cancel', to: 'shopping_carts#cancel'
  get '/shopping_carts/payments', to: 'shopping_carts#payments', :as => 'payments_list'
  get '/shopping_carts/add_to_shopping_cart/:id&:quantity', to: 'shopping_carts#add_to_shopping_cart'
  post '/shopping_carts/payments', to: 'shopping_carts#pay', :as => 'pay'
  post '/shopping_carts/set_product_count', to: 'shopping_carts#set_product_count'
  delete '/shopping_carts/remove_product', to: 'shopping_carts#remove_product'

  get '/payments/index', to: 'payments#index'
  get '/payments/show/:id', to: 'payments#show'
  post '/payments/hook', to: 'payments#hook'

  get '/special_offers/change_page/:page_number', to: 'special_offers#change_page'
  post '/products/:product/rate/', to: 'products#rate'

  resources :payments
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