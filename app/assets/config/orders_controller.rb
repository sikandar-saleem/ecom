# frozen_string_literal: true

class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    # # If this user already have items in cart so we did'not create new order
    # order = Order.where({ user_id: current_user.id, status: 'cart' }).first
    # if order
    #   if order.item_details.create!({ item_id: params[:format], quantity: 1, order_id: order.id })
    #     render js: "alert('Item added to cart');"
    #   else
    #     render js: "alert('error');"
    #   end
    # else
    #   @order = Order.new({ status: 'cart', user_id: current_user.id })
    #   if @order.save
    #     render js: "alert('Item added to cart');" if @order.item_details.create!({ item_id: params[:format],
    #                                                                                quantity: 1, order_id: @order.id })
    #   else
    #     render js: "alert('error');"
    #   end
    # end
  end

  def update
    @order = Order.where({ user_id: current_user.id, status: 'cart' })
    if @order.update({ status: 'order' })
      render js: "alert('Order Placed');"
    else
      render js: "alert('Error in checkout');"
    end
  end

  private

  def order_params
    params.require(:order).permit(:status, :user_id)
  end
end
