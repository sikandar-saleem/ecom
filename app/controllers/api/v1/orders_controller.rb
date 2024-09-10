# frozen_string_literal: true

class Api::V1::OrdersController < BaseController
  before_action :set_order

  # ----------------------------------------------------------------------------
  # POST: http://localhost:3000/api/v1/order/add_item
  # Payload: { "item_id": 17, "quantity" : 1 }
  # ----------------------------------------------------------------------------
  def add_item
    response = OrderService.add_item(@order, params)
    if response[:success]
      success_response(message: response[:message], data: { total_price: response[:total_price] })
    else
      error_response(message: response[:message])
    end
  end

  # ----------------------------------------------------------------------------
  # DELETE: http://localhost:3000/api/v1/order/add_item/:item_id
  # ----------------------------------------------------------------------------
  def remove_item
    response = OrderService.remove_item(@order, params[:item_id])
    if response[:success]
      success_response(message: response[:message], data: { total_price: response[:total_price] })
    else
      error_response(message: response[:message])
    end
  end

  # ----------------------------------------------------------------------------
  # PUT: http://localhost:3000/api/v1/order/mark_completed
  # ----------------------------------------------------------------------------
  def mark_completed
    response = OrderService.mark_complete(@order)
    if response[:success]
      success_response(message: response[:message])
    else
      error_response(message: response[:message])
    end
  end

  private

  def set_order
    current_user = Customer.first # Replace this with actual logged-in user
    @order = current_user.orders.find_or_create_by!(status: 'pending')
  end
end
