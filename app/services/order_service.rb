# frozen_string_literal: true

class OrderService < ApplicationService
  class << self
    def add_item(order, params)
      order_item = order.order_items.find_or_initialize_by(item_id: params[:item_id])
      new_quantity = (order_item.quantity || 0) + params[:quantity].to_i
      item_quantity = Item.find(params[:item_id])&.quantity

      if new_quantity > item_quantity
        available_qty = item_quantity - (order_item.quantity || 0)
        { success: false, message: "#{available_qty} items available in stock!" }
      elsif order_item.update!(quantity: new_quantity)
        { success: true, total_price: order.total_price, message: 'Item added successfully!' }
      else
        { success: false, message: order_item.errors.full_messages }
      end
    end

    def remove_item(order, item_id)
      order_item = order.order_items.find_by(item_id: item_id)

      if order_item&.destroy!
        { success: true, total_price: order.total_price, message: 'Item removed successfully!' }
      else
        { success: false, message: order_item&.errors&.full_messages }
      end
    end

    def mark_complete(order)
      return { success: false, message: 'Add items to the order!' } if order.order_items.empty?

      ActiveRecord::Base.transaction do
        order.order_items.includes(:item).find_each do |order_item|
          item = Item.lock.find(order_item.item_id)
          raise ActiveRecord::Rollback, "Not enough stock for item: #{item.name}" if order_item.quantity > item.quantity
        end

        order.completed!
        order.update_stock

        { success: true, message: 'Order completed successfully!' }
      rescue StandardError => e
        { success: false, message: "Failed to complete the order: #{e.message}" }
      end
    end
  end
end
