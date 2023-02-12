# frozen_string_literal: true

class CreateItemCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :item_categories, &:timestamps
  end
end
