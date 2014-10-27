Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'users/confirmations', passwords: 'users/passwords' }

  root 'application#index'
  resources :settings, only: [:new, :create, :update]
  resources :users, only: [:index]

end
