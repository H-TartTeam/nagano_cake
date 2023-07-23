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
  resources :customers, only: [:index, :show, :edit, :update]
  resources :genres, only: [:index, :edit, :create, :update]
  resources :items, only: [:index, :show, :edit, :create, :update, :new]
 end

  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
    get 'customers/mypage' => 'customers#show'
    get 'customers/infomation/edit' => 'customers#edit'
    patch '/customers/edit' => 'customers#update'
    resources :items, only: [:index, :show]
    resources :customers, only: [:new, :create, :show, :edit, :update, :confirm_withdraw, :withdraw]
    # orders
    get 'orders/confirm' => 'orders#confirm'
    resources :orders, only: [:new, :create, :index, :show] do
      #データ全体に行いたいのでcollection
      collection do
        post 'confirm'
        get 'completed'
      end
    end
    #cart_item
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'clear'
      end
    end
  end
 end
