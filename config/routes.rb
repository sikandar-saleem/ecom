# frozen_string_literal: true

Rails.application.routes.draw do
  root 'items#index'
  resources :categories
  resources :items
  devise_for :users
  resources :admin_dashboards, only: %i[index show]
  resources :orders, except: %i[edit destroy]
  resources :carts, only: %i[index]
  resources :item_details, only: %i[update destroy]

  get '/admin/items', to: 'items#admin_index'
  put '/order-status-update', to: 'orders#update_status'
end
