Rails.application.routes.draw do

  devise_for :users

  root 'application#index'

  put 'settings', controller: :settings, action: :update
  get 'settings/edit', controller: :settings, action: :edit

  resources :users, only: [:index, :edit, :update, :show]

end
