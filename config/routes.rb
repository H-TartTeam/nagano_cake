Rails.application.routes.draw do

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
  get "/" => "homes#top"
  end

  scope module: :public do
  root "homes#top"
  get "/about" => "homes#about"
  resources :items, only: [:index, :show,]
  resources :sessio, only: [:index, :show,]
  resources :customers, only: [:show, :edit, :update, :confirm_withdraw, :withdraw]
  resources :orders, only: [:index, :show, :confirm, :complete]
    get 'cart_items/index'
  end



end
