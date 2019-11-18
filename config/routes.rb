Rails.application.routes.draw do
  devise_for :users
  resources :places do
    resources :comments, only: [:create]
    collection do
      get :all
    end
  end
  resources :users, only: [:edit, :update]
  root to: 'places#index'
end
