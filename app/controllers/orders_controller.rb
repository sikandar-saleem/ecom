# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :user_login, only: %i[update]

  def new
    @order = Order.new
  end

  def index
    @orders = Order.orders(current_user)
  end

  def show
    @order_items = Order.order_detail(current_user, params[:id])
  end

  def create
    ActiveRecord::Base.transaction do
      order = Order.find_or_initialize_by(user: current_user, category: :cart)
      order.save!
      item_detail = order.item_details.find_or_initialize_by(item_id: params[:id])
      item_detail.update!(quantity: item_detail.quantity + 1)
      render js: "alert('Item added to cart');"
    rescue StandardError
      render js: "alert('Error -> Item not added to cart');"
      raise ActiveRecord::Rollback
    end
  end

  def update
    @order = Order.where({ user_id: current_user.id, category: :cart })
    if @order.update({ category: params[:category], total: params[:total] })
      redirect_to order_path(@order.ids)
    else
      render js: "alert('Error in checkout');"
    end
  end

  def update_status
    @order = Order.find(params[:id])
    @orders = Order.admin_orders
    if @order.update(status: params[:status])
      @order_group_count = Order.where.not(category: :cart).group(:status).count
      respond_to do |format|
        format.js
      end
    else
      render js: "alert('Error -> to update status of order.')"
    end
  end

  private

  def order_params
    params.require(:order).permit(:type, :status, :user_id)
  end

  def user_login
    redirect_to new_user_session_path unless current_user
  end
end
