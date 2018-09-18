Rails.application.routes.draw do
  devise_for :users, controllers: {
    #sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 # root to: "home#index"
  root 'products#index'
  get 'welcome/index', 'welcome#index'

  # Carts
  # create cart
  post 'add_to_cart', action: 'create', controller: 'carts'
  # get 'cart/:id',

  # Orders
  # create order
  get 'make_order', action: 'create', controller: 'orders'

  # resources
  resources :products
  resources :orders
  resources :carts  #This should not have been done, as only two resources are needed
  # i.e. 'index', 'create', 'update' and destroy..and all of these four are custom routes
  resources :reviews
end
