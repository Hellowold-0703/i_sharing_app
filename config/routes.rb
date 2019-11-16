Rails.application.routes.draw do
  devise_for :users
  resources :places do
    collection do
      get :search
    end
  end
  resources :users, only: [:edit, :update]
  root to: 'places#index'
end
