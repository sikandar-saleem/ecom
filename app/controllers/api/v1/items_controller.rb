# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      def index
        items = Item.available

        render json: {
          data: { items: items },
          message: 'Items fetched successfully!'
        }, status: :ok
      end
    end
  end
end
