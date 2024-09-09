
# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: %i[index]

      post 'order/add_item', to: 'orders#add_item'
      put 'order/mark_completed', to: 'orders#mark_completed'
      delete 'order/remove_item/:item_id', to: 'orders#remove_item'
    end
  end
end
