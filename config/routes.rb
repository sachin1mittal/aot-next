Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: :signout
  get 'login', to: 'sessions#login', as: :login

  resources :users, except: [:create, :new, :edit, :destroy]# do
    # put 'add_role'
    # put 'remove_role'
    # post 'change_token'
  # end
  resources  :networks, except: [:show] do
    put 'add_device'
    put 'remove_device'
  end
  resources  :devices, except: [:new, :edit] do
    get 'script'
    put 'toggle'
    put 'add_user'
    put 'remove_user'
  end

  root to: "devices#index"
end
