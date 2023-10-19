Rails.application.routes.draw do
  root 'static_pages#top'
  get "login", to: "user_sessions#new"
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users
  resources :events
  resources :bulletins do
    member do
      post 'like'
      delete 'unlike'
    end
  end
end
