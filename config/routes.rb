Rails.application.routes.draw do

  get 'access/menu'
  get 'access/login'
  post 'access/login'
  get 'access/logout'
  get 'admin', to: 'access#menu'
  get "/", to: "posts#index"
  resources :posts do
    resources :likes
    resources :comments do
      resources :likes
    end
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
