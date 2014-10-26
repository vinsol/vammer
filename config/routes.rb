Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'users/confirmations', sessions: 'users/sessions' }
  root 'application#index'
  resources :settings, only: [:new, :create, :update]
  resources :users, only: [:index, :edit, :update]

end
