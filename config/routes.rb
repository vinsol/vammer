Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'users/confirmations', registrations: 'users/registrations', passwords: 'users/passwords' }

  root 'users#index'

end
