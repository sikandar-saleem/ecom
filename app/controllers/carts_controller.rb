# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    @user_cart_items = Order.where(category: 'cart', user_id: current_user&.id).joins(item_details: :item)
                            .select(' title, price,  quantity, item_details.id').order('item_details.created_at ASC')
  end
end
