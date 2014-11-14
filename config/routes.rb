Rails.application.routes.draw do

  get "hashtags/:hashtag",   to: "hashtags#show",      as: :hashtag
  get "hashtags",            to: "hashtags#index",     as: :hashtags

  devise_for :users, controllers: { confirmations: 'users/confirmations' }

  root 'home#index'

  namespace :admin do
    #FIXME_AB: can we make it a singular resource: http://guides.rubyonrails.org/routing.html#singular-resources
    resources :settings, only: [:update]
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

  scope shallow_path: 'comment' do
    resources :posts, only: [:create, :destroy] do
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy] do
        resources :likes, only: [:create, :destroy], shallow: true
      end
    end
  end
  resources :attachments, only: [:destroy]

end
