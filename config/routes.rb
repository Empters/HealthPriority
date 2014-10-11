Rails.application.routes.draw do

  root :to => "home#index"

  resources :users

  resources :products

  get ':controller(/:action(/:id(.:format)))'
end
