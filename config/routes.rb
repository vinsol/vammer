Rails.application.routes.draw do

  devise_for :users

  root 'application#index'

  put 'settings', controller: :settings, action: :update
  get 'settings/edit', controller: :settings, action: :edit

  resources :users, only: [:index, :edit, :update, :show]

  resources :groups, only: [:index, :new, :create, :edit, :update] do
    member do
      get 'unjoin'
      get 'join'
    end
  end

  get 'groups/other', controller: :groups, action: :other

  get 'groups/owned', controller: :groups, action: :owned

end
