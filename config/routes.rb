Rails.application.routes.draw do



  get "search" => "searches#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  post 'users'=>'users#create'
  get 'home/about', to: 'homes#about', as: 'about'
  root to: 'homes#top'


  # bookの投稿にコメント？？
  resources :books, only:[:new, :create, :destroy, :index, :show, :edit, :update]do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only:[:show, :edit, :index, :update]
  resources :favorites, only: [:create, :destroy]

  resources :users do
    member do
      get :following, :followers
    end
end

  resources :relationships, only: [:create, :destroy]
  delete '/relationships', to: 'relationships#destroy', as: 'destroy_relationship'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end