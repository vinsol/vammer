Rails.application.routes.draw do

  get "hashtags/:hashtag",   to: "hashtags#show",      as: :hashtag
  get "hashtags",            to: "hashtags#index",     as: :hashtags

  devise_for :users, controllers: { confirmations: 'users/confirmations' }

  root 'home#index'

  namespace :admin do
    resources :settings, only: [:update]
    get 'settings/edit', to: 'settings#edit'
  end

  resources :users, only: [:index, :edit, :update, :show] do
    collection do
      get 'mentioned'
    end
    member do
      post 'follow', to: 'users#follow'
      delete 'unfollow', to: 'users#unfollow'
      get 'follower', to: 'users#follower'
      get 'following', to: 'users#following'
    end
  end
  get 'users/mentioned_users/:name', to: 'users#mentioned_users', as: :mentioned

  resources :groups, except: [:destroy] do
    member do
      get 'unjoin', to: 'groups#unjoin'
      get 'join', to: 'groups#join'
      get 'members', to: 'groups#members'
    end
    collection do
      get 'owned', to: 'groups#owned'
      get 'extraneous', to: 'groups#extraneous'
    end
  end

  scope shallow_path: 'comment' do
    resources :posts, only: [:create, :destroy, :show] do
      post 'like', to: 'posts#like'
      delete 'unlike/:id', to: 'posts#unlike', as: :unlike
      resources :comments, only: [:create, :destroy] do
        post 'like', to: 'comments#like'
        delete 'unlike/:id', to: 'comments#unlike', as: :unlike
      end
    end
  end
  resources :attachments, only: [:destroy, :create]

end
