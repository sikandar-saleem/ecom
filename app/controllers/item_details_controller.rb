# frozen_string_literal: true

class ItemDetailsController < ApplicationController
  before_action :set_item_detail, only: %i[update destroy]
  before_action :set_cart_items, only: %i[update destroy]

  def update
    new_qty = Integer(params[:quantity])
    new_qty = 1 if new_qty < 1
    render js: "alert('Error -> to update item quantity.')" unless @item_detail.update(quantity: new_qty)
  end

  def destroy
    render js: "alert('Error -> to remove an item from cart.')" unless @item_detail.destroy
  end

  private

  def set_item_detail
    @item_detail = ItemDetail.find(params[:id])
  end

  def item_params
    params.require(:item_detail).permit(:order_id, :item_id, :quantity)
  end

  def set_cart_items
    @user_cart_items = Order.where(category: :cart, user_id: current_user&.id).joins(item_details: :item)
                            .select(' title, price,  quantity, item_details.id').order('item_details.created_at ASC')
  end
end
