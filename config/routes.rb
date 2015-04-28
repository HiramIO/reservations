Rails.application.routes.draw do

  root 'restaurants#index'

  resources :restaurants, only: [:index, :show] do
    resources :reservations, only: [:show, :new, :create, :destroy]
  end

  resources :users, only: [:new, :create, :show] do
     resources :reservations, only: [:show, :new, :create, :destroy]
  end


  resources :sessions, only: [:new, :create, :destroy]

end
