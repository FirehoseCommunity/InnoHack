Rails.application.routes.draw do
  get "hashtags/:hashtag",   to: "hashtags#show",      as: :hashtag
  get "hashtags",            to: "hashtags#index",     as: :hashtags

  devise_for :users

  get 'static_pages/index'
  root 'static_pages#index'

  get 'about', to: 'static_pages#about'

  resources :shares do
    member do
      post 'upvote'
    end

    resources :comments, only: [:create, :destroy, :edit, :update]
  end

  resources :users do
    member do
      post :follow
    end
  end

  resources :users, only: [:show]
end
