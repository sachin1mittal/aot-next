Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: :signout
  get 'login', to: 'sessions#login', as: :login
  get 'dashboard', to: 'users#dashboard', as: :dashboard

  get 'users/search_by_email', to: 'users#search_by_email'
  get 'users/help', to: 'users#help'
  get 'devices/sdks', to: 'devices#sdks'
  # get 'devices/dummy', to: 'devices#dummy'
  resources :users, only: [:show]
  # do
    # put 'add_role'
    # put 'remove_role'
    # post 'change_token'
  # end
  # resources  :networks, except: [:show] do
  #   put 'add_device'
  #   put 'remove_device'
  # end
  resources  :devices, except: [:new, :edit] do
    get 'script'
    put 'toggle'
    put 'add_user'
    put 'remove_user'
    # put 'add_network'
  end

  root to: "users#dashboard"
end
