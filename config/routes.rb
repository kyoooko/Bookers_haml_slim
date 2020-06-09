Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  devise_for :users
  resources :users, only: [:show, :edit, :index, :update]
  resources :books, only: [:show, :edit, :index, :update, :create, :destroy] do
    # いいね機能
    resource :favorites, only: [:create, :destroy]
    # コメント機能
    resources :book_comments, only: [:create, :destroy]
  end
  # フォロー機能
  resources :relationships, only: [:create, :destroy]
  get 'users/:id/follows' => "users#follows"
  get 'users/:id/followers' => "users#followers"

  # 検索機能
  get 'search' => 'searches#search'
  # チャット
  resources :chats, only: [:show, :create]
end
