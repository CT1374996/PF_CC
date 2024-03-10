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
    get 'users/mypage' => 'users#show'
    get 'users/mypage/edit' => 'users#edit'
    patch 'users/mypage/update' => 'users#update'
    get 'users/impressions/index' => 'users#index'
    get 'users/favorites' => 'users#favorites'
    get 'users/confirm' => 'users#confirm'
    patch 'users/withdrawal' => 'users#withdrawal'
    get '/search' => 'searches#search'
    resources :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
    resources :impressions, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      end
  end
  namespace :admin do
    root to: "homes#top"
    get '/search' => 'searches#search'
    resources :impressions, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
      end
    resources :users, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end