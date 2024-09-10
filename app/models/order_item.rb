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
    discount = (item.discount_percentage * item.price) / 100

    self.free_with_id = item.free_with_id
    self.price = ((item.price - discount) * quantity)&.round(2)
    self.tax = ((item.tax_rate * price) / 100)&.round(2)
  end

  def update_order_total
    order.update!(total_price: order.order_total)
  end
end
