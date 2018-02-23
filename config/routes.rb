Rails.application.routes.draw do
  
  get 'ownerships/create'

  get 'ownerships/destroy'

  get 'items/new'

  get 'password_resets/new'

  get 'password_resets/edit'

 root to: 'toppages#index'
  get 'signup', to:'users#new'
  
  get    'login' ,  to: 'sessions#new'
  post   'login' ,  to: 'sessions#create'
  delete 'logout' , to: 'sessions#destroy'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :items, only: [:show,:new]
  resources :ownerships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
