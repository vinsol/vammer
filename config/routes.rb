Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'users/confirmations' }

  root 'homes#index'

  namespace :admin do
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

  scope shallow_path: 'comment' do
    resources :posts, only: [:create, :destroy] do
      resources :attachments, only: [:destroy]
      resources :comments, only: [:create, :destroy] do
        resources :attachments, only: [:destroy], shallow: true
      end
    end
  end

end
