Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'users/confirmations', passwords: 'users/passwords' }
  root 'users#index'
  put 'settings', controller: :settings, action: :update
  get 'settings/edit', controller: :settings, action: :edit

end
