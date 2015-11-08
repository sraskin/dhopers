class OrderEventMailer < ApplicationMailer

  def order_received(order, user)
    @order = order
    @user = user

    mail(to: @user.email, subject: "Dhopers: Your order (##{@order.order_number}) Order Received")
  end

  def order_processed(order, user)
    @order = order
    @user = user

    mail(to: @user.email, subject: "Dhopers: Your order (##{@order.order_number}) has been processed successfully")
  end

  def order_delivery_notification(order, user)
    @order = order
    @user = user

    mail(to: @user.email, subject: "Dhopers: [Your order (##{@order.order_number}) has been delivered")
  end

end
