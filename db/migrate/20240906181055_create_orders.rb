# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.float :total_price, null: false, default: 0.0
      t.integer :status, null: false, default: 0

      t.references :customer

      t.timestamps
    end
  end
end
