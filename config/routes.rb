Rails.application.routes.draw do
  devise_for :users,skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin,skip:[:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    get 'users/mypage' => 'users#show'
    get 'users/mypage/edit' => 'users#edit'
    patch 'users/mypage/update' => 'users#update'
    get 'users/confirm' => 'users#confirm'
    patch 'users_withdrawal' => 'users#withdrawal'
    post '/search', to: 'impressions#search'
    get '/search', to: 'impressions#search'
    resources :impressions, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      end
  end
  namespace :admin do
    root to: "homes#top"
    resources :impressions, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
      end
    resources :users, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end