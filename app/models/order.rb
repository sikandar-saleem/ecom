# frozen_string_literal: true

class Order < ApplicationRecord
  # --------------------------------------------------------------------------------------------------------
  # ASSOCIATIONS
  # --------------------------------------------------------------------------------------------------------
  belongs_to :customer

  has_many :order_items, dependent: :restrict_with_error
  has_many :items, through: :order_items

  # --------------------------------------------------------------------------------------------------------
  # VALIDATION
  # --------------------------------------------------------------------------------------------------------
  validates :total_price, :status, presence: true

  # --------------------------------------------------------------------------------------------------------
  # CALLBACKS
  # --------------------------------------------------------------------------------------------------------
  after_update_commit :send_order_completion_email, if: :order_marked_completed?

  # --------------------------------------------------------------------------------------------------------
  # ENUMS
  # --------------------------------------------------------------------------------------------------------
  enum :status, { pending: 0, completed: 1 }

  # --------------------------------------------------------------------------------------------------------
  #  PUBLIC METHODS
  # --------------------------------------------------------------------------------------------------------

  def order_total
    # Find all order_items where the item is free with another item
    free_items = order_items.joins(:item).where.not(items: { free_with_id: nil })

    # Filter out free items only if their associated 'free_with_id' item exists in the order
    free_item_ids_to_exclude = free_items.select do |order_item|
      order_items.exists?(item_id: order_item.item.free_with_id)
    end.map(&:id)

    # Calculate the total price, excluding the price of free items
    order_items
      .where.not(id: free_item_ids_to_exclude) # Exclude free items if their "free" condition is met
      .sum('order_items.price + order_items.tax') # Sum the price and tax for all valid items
      .to_f
      .round(2)
  end

  def update_stock
    order_items.includes(:item).find_each do |order_item|
      new_qunatity = order_item.item.quantity - order_item.quantity
      order_item.item.update!(quantity: new_qunatity)
    end
  end

  def send_order_completion_email
    # Ideally handled by background worker
    OrderMailer.order_completed(id).deliver_now
  end

  # --------------------------------------------------------------------------------------------------------
  #  PRIVATE INSTANCE METHODS
  # --------------------------------------------------------------------------------------------------------
  private

  def order_marked_completed?
    completed? && previous_changes['status'] != 'completed'
  end
end
