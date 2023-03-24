Rails.application.routes.draw do
  devise_for :users

  # ユーザーの新規登録はdeviseに含まれているため不要
  # POSTで受け付けるルーティングもRESTfulにする
  resources :users, only: [:create]

  get 'home/about', to: 'homes#about', as: 'about'
  root to: 'homes#top'

  resources :books do
    # 単数形に変更し、フォームの送信先URLが適切になるようにする
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :index, :update] do
    # ルーティングが重複しているため、ここで member ブロックを使う
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  # DELETEメソッドを使うためのルーティング

  delete '/relationships/:id', to: 'relationships#destroy', as: 'destroy_relationship'


  # 検索機能用のルーティング
  get "search", to: "searches#search"

end
