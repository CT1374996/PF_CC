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
    get 'users/profile/edit' => 'users#edit'
    patch 'users/profile/update' => 'users#update'
    get 'users/confirm' => 'users#confirm'
    patch 'users_withdrawal' => 'users#withdrawal'
  end
  namespace :admin do
    root to: "homes#top"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
