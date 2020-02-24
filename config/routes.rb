Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :beers, only: [:index, :show] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
  get 'scan', to: 'beers#scan'
  get '/myreviews', to: 'reviews#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
