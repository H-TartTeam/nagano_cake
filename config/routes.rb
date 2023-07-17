Rails.application.routes.draw do
  devise_for :costomers
  namespace :public do
    get "/" => "homes#top"
    get 'homes/about'
  end
  namespace :public do
    get 'items/show'
    get 'items/index'
  end
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
