Rails.application.routes.draw do
  devise_for :users
  resources :places
  root to: 'places#index'
end
