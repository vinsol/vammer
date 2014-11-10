Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'users/confirmations' }

  root 'homes#index'

  namespace :admin do
    #FIXME_AB: can we make it a singular resource: http://guides.rubyonrails.org/routing.html#singular-resources
    resources :settings, only: [:update]
    get 'settings/edit', controller: :settings, action: :edit
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
