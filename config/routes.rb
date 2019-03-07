Rails.application.routes.draw do
  root to: "posts#index"
  get 'access/menu'
  get 'access/login'
  post 'access/login'
  get 'access/logout'
  get "access/admin_login"
  post "access/admin_login"
  get "access/admin_logout"
  get 'admin', to: 'access#menu'
  get "/dank", to: "posts#dank"
  get "/fresh", to: "posts#fresh"
  get '/top', to: "posts#top"
  resources :posts do
    resources :reports
    resources :likes
    resources :comments do
      resources :likes
    end
  end
  resources :comments do
    resources :reports
    resources :comments
  end
  resources :users do
    resources :reports
  end
  post 'posts/:id', to: "posts#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
