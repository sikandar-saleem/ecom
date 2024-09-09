# frozen_string_literal: true

class OrderItem < ApplicationRecord
  # --------------------------------------------------------------------------------------------------------
  # ASSOCIATIONS
  # --------------------------------------------------------------------------------------------------------
  belongs_to :item
  belongs_to :order

  # --------------------------------------------------------------------------------------------------------
  # CALLBACKS
  # --------------------------------------------------------------------------------------------------------
  before_save :calculate_price_and_tax
  after_commit :update_order_total

  # --------------------------------------------------------------------------------------------------------
  # PRIVATE METHODS
  # --------------------------------------------------------------------------------------------------------
  private

  def calculate_price_and_tax
    free_item_present = order.order_items.exists?(item_id: item.free_with_id)

    discount = (item.discount_percentage * item.price) / 100
    final_price = item.free_with_id.present? && free_item_present ? 0.0 : item.price - discount

    self.price = (final_price * quantity)&.round(2)
    self.tax = ((item.tax_rate * price) / 100)&.round(2)
  end

  def update_order_total
    order.update!(total_price: order.order_total)
  end
end
