class OrderEventMailer < ApplicationMailer

  default from: 'no-reply@dhopers.com'


  def order_received(order)
    @order = order
    @user  = @order.user
    @url   = @order.order_path

    mail(to: @user.email, subject: "Dhopers: Your order (##{@order.order_number}) Order Received")
  end

  def order_processed(order)
    @order = order
    @user  = @order.user
    @url   = @order.order_path

    mail(to: @user.email, subject: "Dhopers: Your order (##{@order.order_number}) has been processed successfully")
  end

  def order_delivery_notification(order)
    @order = order
    @user  = @order.user
    @url   = @order.order_path

    mail(to: @user.email, subject: "Dhopers: [Your order (##{@order.order_number}) has been delivered")
  end

end
