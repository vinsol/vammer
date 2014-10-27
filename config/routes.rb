Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'users/confirmations' }
  root 'users#index'
  resources :settings, only: [:new, :create, :update]

end
