Rails.application.routes.draw do
  resources :users

  resources :products

  get ':controller(/:action(/:id(.:format)))'
end
