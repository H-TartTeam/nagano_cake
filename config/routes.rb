Rails.application.routes.draw do
  namespace :public do
    get 'orders/show'
    get 'orders/index'
    get 'orders/confirm'
    get 'orders/complete'
  end
  namespace :public do
    get 'cart_items/index'
  end
  devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
