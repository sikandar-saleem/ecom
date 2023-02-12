# frozen_string_literal: true

class User < ApplicationRecord
  has_many :orders, dependent: :nullify

  validates :full_name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, admin: 1 }

  validate :username_empty_or_greater_than_one_char

  def username_empty_or_greater_than_one_char
    errors.add(:username, 'can be blank or atleast two characters') if username.present? && username.size < 2
  end
end
