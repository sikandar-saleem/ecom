# frozen_string_literal: true

class Customer < ApplicationRecord
  # --------------------------------------------------------------------------------------------------------
  # ASSOCIATIONS
  # --------------------------------------------------------------------------------------------------------
  has_many :orders, dependent: :restrict_with_error

  # --------------------------------------------------------------------------------------------------------
  # VALIDATIONS
  # --------------------------------------------------------------------------------------------------------
  validates :first_name, :email, :phone, presence: true
end
