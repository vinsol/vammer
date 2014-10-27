Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'users/confirmations', passwords: 'users/passwords', sessions: 'users/sessions' }

  root 'application#index'
  resources :settings, only: [:new, :create, :update]
  resources :users, only: [:index, :edit, :update]

end
