# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.integer :quantity, null: false
      t.bigint :discounted_item_id
      t.bigint :free_with_id
      t.float :tax_rate, null: false, default: 0.0
      t.float :discount_percentage, null: false, default: 0.0

      t.references :category
      t.timestamps
    end
  end
end
