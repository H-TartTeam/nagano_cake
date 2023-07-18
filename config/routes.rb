Rails.application.routes.draw do

  devise_for :admins
  devise_for :customers



  scope module: :public do
  root "homes#top"
  resources :orders, only: [:index, :show, :onfirm, :complete]
  get "/about" => "homes#about"
  resources :items, only: [:index, :show,]
  get 'orders/show'
  get 'orders/index'
  get 'orders/confirm'
  get 'orders/complete'
  get 'cart_items/index'
 end
end