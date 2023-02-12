# frozen_string_literal: true

class CreateItemDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :item_details do |t|
      t.integer    :quantity, null: false
      t.belongs_to :item, foreign_key: true, index: true, null: false
      t.belongs_to :order, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
