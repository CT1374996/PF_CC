Rails.application.routes.draw do
  devise_for :users,skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#new_guest'
  end
  devise_for :admin,skip:[:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    get 'users/impressions/index/:user_id' => 'users#index', as: 'users_impressions_index'
    get 'users/favorites/:user_id' => 'users#favorites', as: 'users_favorites'

    get 'users/confirm' => 'users#confirm'
    patch 'users/withdrawal' => 'users#withdrawal'
    resources :users, only: [:show, :edit, :update] do
      resources :reports, only: [:new, :create]
      resources :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
      end
    get '/search' => 'searches#search'
    resources :impressions, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      end
    resources :notifications, only:[:index]
  end
  namespace :admin do
    root to: "homes#top"
    get '/search' => 'searches#search'
    resources :impressions, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
      end
    patch 'users/withdrawal/:user_id' => 'users#withdrawal', as: 'users_withdrawal'
    resources :reports, only: [:index, :show, :update]
    resources :users, only: [:index, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end