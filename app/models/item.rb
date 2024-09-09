# frozen_string_literal: true

class Item < ApplicationRecord
  # --------------------------------------------------------------------------------------------------------
  # ASSOCIATIONS
  # --------------------------------------------------------------------------------------------------------

  belongs_to :category
  belongs_to :free_with, class_name: 'Item', optional: true, inverse_of: :items
  belongs_to :discounted_item, class_name: 'Item', optional: true, inverse_of: :items

  has_many :order_items, dependent: :restrict_with_error
  has_many :orders, through: :order_items

  # --------------------------------------------------------------------------------------------------------
  # VALIDATIONS
  # --------------------------------------------------------------------------------------------------------
  validates :name, :price, :quantity, presence: true

  # --------------------------------------------------------------------------------------------------------
  # SCOPES
  # --------------------------------------------------------------------------------------------------------
  scope :available, -> { where(quantity: 1..) }
  scope :not_available, -> { where(quantity: 0) }
end
