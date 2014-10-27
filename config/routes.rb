Rails.application.routes.draw do

  devise_for :users, controllers: { passwords: 'users/passwords' }

  root 'users#index'

end
