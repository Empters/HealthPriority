Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root to: 'home#index'

  post 'import_products_post' => 'admin#import_products#import'

  ActiveAdmin.routes(self)

  # Init active admin
  devise_for :admin_users, ActiveAdmin::Devise.config

  # Init login gem
  devise_for :users, controllers: {:sessions => 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations'}

  get '/:locale/home/change_page/:page_number', to: 'home#change_page'
  get '/:locale/home/about_us', to: 'home#about_us', :as => 'about_us'
  get '/:locale/home/contacts', to: 'home#contacts', :as => 'contacts'
  get '/:locale/home/faq', to: 'home#faq', :as => 'faq'
  get '/:locale/home/our_partners', to: 'home#our_partners', :as => 'our_partners'
  get '/:locale/home/delivery_methods', to: 'home#delivery_methods', :as => 'delivery_methods'
  get '/:locale/home/payment_methods', to: 'home#payment_methods', :as => 'payment_methods'
  get '/:locale/home/help_center', to: 'home#help_center', :as => 'help_center'
  get '/:locale/home/price_details', to: 'home#price_details', :as => 'price_details'
  get '/:locale/home/update_states', to: 'home#update_states', :as => 'update_states'
  post '/home/send_message', to: 'home#send_message'

  get '/:locale/products/search/(:token)(/category/:category)', to: 'products#search', :as => 'search'
  get '/:locale/products/autocomplete/:query', to: 'products#autocomplete'
  get '/:locale/products/filter/:category', to: 'products#filter', :as => 'filter'
  get '/:locale/products/brand/:brand', to: 'products#brand', :as => 'brand'
  get '/:locale/products/price/:range', to: 'products#price', :as => 'price'
  get '/:locale/products/change_page/:page_number', to: 'products#change_page'

  get '/:locale/shopping_carts/pay', to: 'shopping_carts#pay'
  get '/:locale/shopping_carts/success', to: 'shopping_carts#success'
  get '/:locale/shopping_carts/cancel', to: 'shopping_carts#cancel'
  get '/:locale/shopping_carts/payments', to: 'shopping_carts#payments', :as => 'payments_list'
  get '/:locale/shopping_carts/add_to_shopping_cart/:id&:quantity', to: 'shopping_carts#add_to_shopping_cart'
  post '/shopping_carts/payments', to: 'shopping_carts#pay', :as => 'pay'
  post '/shopping_carts/set_product_count', to: 'shopping_carts#set_product_count'
  delete '/shopping_carts/remove_product', to: 'shopping_carts#remove_product'

  get '/:locale/payments/show/:id', to: 'payments#show'
  post '/payments/show/:id', to: 'payments#show'
  post '/show/payments/:id', to: 'payments#show'
  post '/payments/hook', to: 'payments#hook'

  get '/:locale/special_offers/change_page/:page_number', to: 'special_offers#change_page'
  post '/products/:product/rate/', to: 'products#rate'

  scope '/:locale', locale: /en|bg/ do
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
  end

end