# frozen_string_literal: true

class AdminDashboardPolicy < ApplicationPolicy
  def index?
    @user&.admin?
  end

  def show?
    @user&.admin?
  end
end
