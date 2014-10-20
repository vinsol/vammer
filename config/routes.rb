Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'users/confirmations', passwords: 'users/passwords' }
  root 'users#index'
  resources :settings, only: [:new, :create, :update]

end
