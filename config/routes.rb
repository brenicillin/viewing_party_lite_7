Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"
  get "/login", to: 'users#login_form'
  post "/login", to: 'users#login_user'
  get "/register", to: "users#new", as: "new_user"

  resources :users, only: [:show, :create] do
    resources :movies, only: [:index, :show] do
      resources :viewing_parties, only: [:new, :create]
    end
    get "/discover", to: "discover#index"
  end

end
