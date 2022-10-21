Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  namespace :public do
    root to: "homes#top"
    get "/about" =>"homes#about"
    resources :items
    resources :customers
    resources :cart_items
    resources :orders
    resources :addresses
  end

  namespace :admin do
    root "homes#top"
    resources :items
    resources :genres
    resources :customers
    resources :orders
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
