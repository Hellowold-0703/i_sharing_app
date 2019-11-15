Rails.application.routes.draw do
  devise_for :users
  resources :places
  resources :users, only: [:edit, :update]
  root to: 'places#index'
end
