Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords', sessions: 'users/sessions' }

  root 'application#index'

  put 'settings', controller: :settings, action: :update
  get 'settings/edit', controller: :settings, action: :edit

  resources :users, only: [:index, :edit, :update, :show]

end
