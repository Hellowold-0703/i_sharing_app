Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :places do
    resources :comments, only: [:create, :destroy]
    collection do
      get :all
    end
  end
  resources :users, only: [:edit, :update]
  root to: 'places#index'
  resources :notifications, only: [:index, :destroy]

  namespace :api do
    resources "destroy", controller: :places, only: :image_destroy, defaults: { format: 'json'} do
      collection do
        delete "image_destroy"
      end
    end
  end


  get    '/users/:id/likes' => 'users#likes'
  post   '/like/:place_id' => 'likes#like',   as: 'like'
  delete '/like/:place_id' => 'likes#unlike', as: 'unlike'
end
