Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  post 'users'=>'users#create'
  get 'home/about', to: 'homes#about', as: 'about'
  root to: 'homes#top'
  
  # bookの投稿にコメント？？
  resources :books, only:[:new, :create, :destroy, :index, :show, :edit, :update] do
    resources :book_comments, only: [:create]
  end
  
  resources :users, only:[:show, :edit, :index, :update]
  resources :favorites, only: [:create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end