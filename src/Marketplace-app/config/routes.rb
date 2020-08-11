Rails.application.routes.draw do
  get "/listings/dashboard", to: "listings#dashboard", as: "listings_dashboard"
  resources :listings
  resources :profiles
  resources :conversations do
    resources :messages
  end
  devise_for :users, controllers: { registrations: "registrations" }
  get "/products/search", to: "products#search", as: "search_products"
  get "/products/cart", to: "products#cart", as: "cart_products"
  post "/products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  delete "products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"
  resources :products
  root to: "products#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
