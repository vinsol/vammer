Rails.application.routes.draw do

  devise_for :users, controllers: { passwords: 'users/passwords', registrations: 'users/registrations' }

  root 'users#index'

end
