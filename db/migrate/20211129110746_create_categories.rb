# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.citext :name, unique: true, null: false

      t.timestamps
    end
  end
end
