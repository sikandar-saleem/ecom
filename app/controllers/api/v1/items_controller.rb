# frozen_string_literal: true

class Api::V1::ItemsController < BaseController
  # ----------------------------------------------------------------------------
  # GET: http://localhost:3000/api/v1/items
  # ----------------------------------------------------------------------------
  def index
    items = Item.available
    success_response(message: 'Items fetched successfully!', data: { items: items })
  end
end
