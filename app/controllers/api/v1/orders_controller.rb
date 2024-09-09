# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      before_action :set_order

      # ---------------------------------------------------------------------
      # POST: BASE_URL/api/v1/order/add_item
      # Payload: {  "item_id": 8, "quantity" : 12 }
      # ---------------------------------------------------------------------
      def add_item
        order_item = @order.order_items.find_or_initialize_by(item_id: params[:item_id])
        new_qunatity = (order_item.quantity || 0) + params[:quantity].to_i
        item_qunatity = Item.find(params[:item_id])&.quantity

        if new_qunatity > item_qunatity
          available_qty = item_qunatity - (order_item.quantity || 0)
          render json: { error: "#{available_qty} items available in stock!" }, status: :unprocessable_entity
        elsif order_item.update!(quantity: new_qunatity)
          render json: {
            data: { total_price: @order.total_price },
            message: 'Item added successfully!'
          }, status: :ok
        else
          render json: { error: order_item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # ---------------------------------------------------------------------
      # DELETE: BASE_URL/api/v1/order/remove_item/:id
      # ---------------------------------------------------------------------
      def remove_item
        order_item = @order.order_items.find_by(item_id: params[:item_id])

        if order_item&.destroy!
          render json: {
            data: { total_price: @order.total_price },
            message: 'Item removed successfully!'
          }, status: :ok
        else
          render json: { error: order_item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # ---------------------------------------------------------------------
      # UPDATE: BASE_URL/api/v1/order/mark_complete/
      # ---------------------------------------------------------------------
      def mark_completed
        render json: { message: 'Add items to the order!' }, status: :unprocessable_entity and return if @order.order_items.empty?

        ActiveRecord::Base.transaction do
          # Lock the stock for each item in the order to prevent race conditions
          @order.order_items.includes(:item).find_each do |order_item|
            item = Item.lock.find(order_item.item_id) # Pessimistic locking
            raise ActiveRecord::Rollback, "Not enough stock for item: #{item.name}" if order_item.quantity > item.quantity
          end

          @order.completed!
          @order.update_stock

          render json: { message: 'Order completed successfully!' }, status: :ok
        rescue StandardError => e
          render json: { error: "Failed to complete the order: #{e.message}" }, status: :unprocessable_entity
          raise ActiveRecord::Rollback
        end
      end

      private

      def set_order
        # Here we taking current customer as first user, but in actuall it will be logged in user
        current_user = Customer.first
        @order = current_user.orders.find_or_create_by!(status: 'pending')
      end
    end
  end
end
