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
  patch '/customers/infomation' => 'customers#update'
  get 'customers/confirm_withdraw' => 'customers#confirm_withdraw'
  patch '/customers/withdraw' => 'customers#withdraw'
  resources :items, only: [:index, :show]
  resource :customers, only: [:new, :create, :show, :edit, :update]
  resources :orders, only: [:new, :index, :show, :confirm, :complete]
  resources :cart_items, only: [:index, :update, :create, :destroy] do
   collection do
    delete 'clear'
   end
  end
 end
end
