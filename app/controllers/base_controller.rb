# frozen_string_literal: true

class BaseController < ApplicationController
  private

  def success_response(message:, data: {}, status: 200)
    render json: {
      data: data,
      message: message,
      success: true,
      status: status

    }
  end

  def error_response(message:, status: 400)
    render json: {
      success: false,
      data: {},
      message: message || 'Something went wrong!',
      status: status
    }
  end
end
