Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'users/confirmations' }

  root 'home#index'

  namespace :admin do
    resource :settings, only: [:update]
    get 'settings/edit', to: 'settings#edit'
  end

  resources :users, only: [:index, :edit, :update, :show]

  resources :groups, except: [:destroy] do
    member do
      get 'unjoin'
      get 'join'
      get 'members'
    end
    collection do
      get 'owned'
      get 'extraneous'
    end
  end

  resources :posts, only: [:create]

end
