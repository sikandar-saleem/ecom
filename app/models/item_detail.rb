# frozen_string_literal: true

class ItemDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  after_initialize :set_default_quanitity, if: :new_record?

  private

  def set_default_quanitity
    self.quantity ||= 0
  end
end
