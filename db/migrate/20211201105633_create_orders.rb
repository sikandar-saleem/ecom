# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer     :category, null: false, default: 0
      t.integer     :status, null: false, default: 0
      t.float :total, default: 0.0, null: false
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
