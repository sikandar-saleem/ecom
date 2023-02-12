# frozen_string_literal: true

class Item < ApplicationRecord
  has_one_attached :image
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  has_many :item_details, dependent: :destroy

  validates :title, :description, :price, :status, presence: true
  validates :title, uniqueness: { case_sensitive: false } # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :categories, length: { minimum: 1, message: "can't be blank" }

  enum status: { active: 0, retired: 1 }
end
