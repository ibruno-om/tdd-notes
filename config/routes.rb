# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :notes do
        resources :items, only: %I[index create update destroy]
        resources :sharings, only: %I[index create update destroy]
        resource :reminders, only: %I[show create destroy]
      end
      resources :user_registrations, only: %I[create]
      # authenticate
      post 'authenticate', to: 'authentication#authenticate'
    end
  end
end
