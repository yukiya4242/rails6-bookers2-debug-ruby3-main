Rails.application.routes.draw do

  devise_for :users


  resources :users, only: [:create]


  resources :groups do
    get "join" => "groups#join"
  end


  get 'home/about', to: 'homes#about', as: 'about'
  root to: 'homes#top'

  resources :books do

    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :index, :update] do
     get "search", to: "users#search"
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:index, :new, :create, :show, :destroy]
  resources :groups, except: [:destroy]

  resources :groups, except: [:destroy] do
  member do
    get :edit
  end
end


  # DELETEメソッドを使うためのルーティング

  delete '/relationships/:id', to: 'relationships#destroy', as: 'destroy_relationship'


  # 検索機能用のルーティング
  get "search", to: "searches#search"


end