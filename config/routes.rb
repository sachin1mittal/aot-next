Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: :signout
  get '/login', to: 'users#login', as: :login

  resources :sessions, only: [:create, :destroy]
  resources :users, except: [:create, :new] do
    put 'add_role'
    put 'remove_role'
    put 'change_token'
  end
  resources  :devices, except: [:show] do
    put 'toggle'
  end

  root to: "devices#index"
end
