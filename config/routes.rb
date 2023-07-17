Rails.application.routes.draw do

  　devise_for :admins
  　devise_for :costomers
  
 　 namespace :public do
    get "/" => "homes#top"
    get 'homes/about'
 　 end
  
　 　　namespace :public do
    get 'items/show'
    get 'items/index'
  　end
  
 　 namespace :public do
    get 'orders/show'
    get 'orders/index'
    get 'orders/confirm'
    get 'orders/complete'
 　 end
  
 　 namespace :public do
    get 'cart_items/index'
  　end
end
