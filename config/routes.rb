# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts, path: '/'
  resources :tags, only: %i[show]
end
