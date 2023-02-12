# frozen_string_literal: true

class Order < ApplicationRecord
  validates :category, :status, :total, presence: true

  has_many :item_details, dependent: :destroy, autosave: true
  belongs_to :user, optional: true

  scope :orders, ->(current_user) { where(user_id: current_user.id, category: 'order') }
  scope :admin_orders, lambda {
                         joins(:user).where.not(category: :cart).select('full_name, email, orders.status,'\
                           'orders.id, orders.created_at').order('orders.created_at ASC')
                       }
  scope :order_detail, lambda { |current_user, id|
                         joins(item_details: :item).where({ user_id: current_user.id, category: 'order', id: id })
                                                   .select('items.title, items.price, item_details.quantity,'\
                                                     'orders.status, items.id, orders.updated_at, orders.total')
                       }
  scope :create_order, lambda { |current_user|
                         new({ status: 'orderd', category: 'cart', user_id: current_user.id, total: 0.0 })
                       }

  enum category: { cart: 0, order: 1 }, _prefix: true
  enum status: { orderd: 0, canceled: 1, paid: 2, completed: 3 }
end
