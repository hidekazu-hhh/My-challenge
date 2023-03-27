Rails.application.routes.draw do
  root 'static_pages#page'
  get 'static_pages/top'
  get 'static_pages/start_page'
  get 'static_pages/hope'
  get 'static_pages/terms_of_service'
  get 'static_pages/privacy_policy'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post '/guest_login', to: 'user_sessions#guest_login'
  resources :users do
    member do
      get :follows, :followers, :calendar, :chart, :column_chart
    end
    resource :relationships, only: [:create, :destroy]
  end
  resources :posts do
    member do
      get :favorite
    end
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: %i[create destroy], shallow: true
  end
  resources :tags, only: %w[index show destroy]
  resources :notifications, only: :index

  namespace :admin do
    root 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    resources :positive_words
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html