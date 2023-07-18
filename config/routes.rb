Rails.application.routes.draw do

  devise_for :admins
  devise_for :customers

  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
    resources :items, only: [:index, :show,]
    resources :orders, only: [:index, :show, :onfirm, :complete]
    get 'cart_items/index'
  end
end

