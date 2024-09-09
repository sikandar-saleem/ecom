# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :email, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
