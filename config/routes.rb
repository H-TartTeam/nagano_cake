Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
    resources :items, only: [:index, :show,]
    resources :customers, only: [:show, :edit, :update, :confirm_withdraw, :withdraw]
    resources :orders, only: [:new, :index, :show, :confirm, :complete]
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      #全体のデータに対するアクション
      collection do
        delete 'clear'
      end
    end
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit]
    resources :genres, only: [:index, :edit, :create, :update]
  end
end