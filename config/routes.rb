Rails.application.routes.draw do
  root 'static_pages#top'
  get "login", to: "user_sessions#new"
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users
  resources :events do
    get 'calendar', on: :collection
  end
  resources :bulletins do
    member do
      post 'like'
      delete 'unlike'
    end
  end
  resources :notifications, only: [:index] do
    member do
      put :mark_as_read
    end
  end
end
