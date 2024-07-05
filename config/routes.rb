Rails.application.routes.draw do
  default_url_options host: ENV.fetch('HOST', 'localhost:3001')

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  root to: 'pages#home'

  resources :tasks do
    member do
      patch :toggle_status
    end
    collection do
      get 'filter'
    end
  end
  resources :calender, only: [:index] do
    collection do
      get :week
      get :month
    end
  end
  resources :achievements
  resources :learnsets do
    member do
      get 'card/', to: 'learnsets#card', as: :card
      get 'card/json', to: 'learnsets#card_json', as: :card_json
    end
  end
end
