# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false } # rubocop:disable Rails/UniqueValidationWithoutIndex

  has_many :item_categories, dependent: :destroy
  has_many :items, through: :item_categories
end
