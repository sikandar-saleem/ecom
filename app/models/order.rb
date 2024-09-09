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
    order_items
      .joins(:item)
      .where(items: { free_with_id: nil })
      .pick(Arel.sql('SUM(order_items.price + order_items.tax)'))&.round(2) || 0.0
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
