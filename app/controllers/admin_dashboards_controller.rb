# frozen_string_literal: true

class AdminDashboardsController < ApplicationController
  before_action :admin_login
  def index
    @orders = Order.joins(:user).where.not(category: :cart).select('full_name, email, orders.status,'\
       'orders.id, orders.created_at').order('orders.created_at ASC')
    @order_group_count = Order.where.not(category: :cart).group(:status).count
  end

  def show
    @order_items = Order.joins(item_details: :item).where(category: :order, id: params[:id])
                        .select('items.title, items.price, item_details.quantity,'\
      'orders.status, items.id, orders.updated_at, orders.total')
    render template: 'orders/show'
  end

  private

  def admin_login
    redirect_to root_path unless current_user&.admin?
  end
end
