# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get '/notifications', to: 'notifications#index', as: 'user_notifications'
  resources :users
  resources :events do
    get 'calendar', on: :collection
    resources :reservations, only: %i[new create destroy]
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
  resources :chat_messages, only: %i[index create]
  resources :bulletin_chats, only: %i[index create]
end
