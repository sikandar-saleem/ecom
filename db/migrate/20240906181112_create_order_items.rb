# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.integer :quantity, null: false
      t.float :price, null: false
      t.float :tax, null: false, default: 0.0

      t.references :order
      t.references :item

      t.timestamps
    end
  end
end
