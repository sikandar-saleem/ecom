# frozen_string_literal: true

class AddReferencesToItemCategories < ActiveRecord::Migration[5.2]
  def change
    add_reference :item_categories, :item, index: true, foreign_key: true, unique: true
    add_reference :item_categories, :category, index: true, foreign_key: true, unique: true
  end
end
