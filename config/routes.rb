# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :notes do
        resources :items, only: %I[index]
      end
    end
  end
end
