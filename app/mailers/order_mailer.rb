# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_completed(id)
    @order = Order.find(id)

    mail(to: @order.customer.email, subject: 'Your order completed successfully')
  end
end
