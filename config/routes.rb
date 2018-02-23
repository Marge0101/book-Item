Rails.application.routes.draw do
  
  get 'rankings/want'

 root to: 'toppages#index'
  get 'signup', to:'users#new'
  
  get    'login' ,        to: 'sessions#new'
  post   'login' ,        to: 'sessions#create'
  delete 'logout' ,       to: 'sessions#destroy'
  get    'rankings/want', to: 'rankings#want'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :items, only: [:show,:new]
  resources :ownerships, only: [:create, :destroy]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
